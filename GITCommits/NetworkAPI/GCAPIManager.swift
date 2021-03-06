//
//  GCAPIManager.swift
//  GITCommits
//
//  Created by Gabriel on 2/5/21.
//

import Foundation

struct GitURLConstants {
    static let url = "https://api.github.com/repos/apple/swift/commits"
}

enum GCError: Error {
    case GCErrorNone
    case GCErrorNetwork
    case GCErrorBadParsing
    case GCErrorOther
}

enum Result {
    case success([GitCommit]?)
    case failure(Error)
}

typealias QueryResult = (Result) -> ()

protocol GCAPIManager_Protocol {
    func getRecentGitCommits(completionHandler: @escaping QueryResult)
}

class GCAPIManager: GCAPIManager_Protocol {
    typealias GenericDictionary = [String:Any]
    private let jsonDecoder: JSONDecoder
    var rapidError = GCError.GCErrorNone
    
    init() {
        self.jsonDecoder = JSONDecoder()
    }
    
    /**
    Fetches recent git commits info from GITHUB API.

    - Parameters:
       - completion: The completion handler to call after completion
    */
    
    final func getRecentGitCommits(completionHandler: @escaping QueryResult) {
        guard let url = URL(string: GitURLConstants.url) else { completionHandler(.failure(GCError.GCErrorOther)); return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (optionalData, optionalResponse, optionalError) in
            guard let strongRef = self else {
                DispatchQueue.main.async {
                    completionHandler(.failure(GCError.GCErrorOther))
                }
                return
            }
            
            guard optionalError == nil,
                  strongRef.isValidResponse(optionalResponse: optionalResponse),
                  let data = optionalData else {
                DispatchQueue.main.async {
                    completionHandler(.failure(GCError.GCErrorOther))
                }
                return
            }
            
            if let gCommits = strongRef.parseData(data) {
                DispatchQueue.main.async {
                    completionHandler(.success(gCommits))
                }
            }
            else {
                DispatchQueue.main.async {
                    completionHandler(.failure(GCError.GCErrorBadParsing))
                }
            }
        }.resume()
    }
    
    /**
    Parses the data from GITHUB API.

    - Parameters:
       - data: The data to be parsed
     
    - Returns: The git commits received from API.
    */
    
    private func parseData (_ data: Data) -> [GitCommit]? {
        do {
            let gitCommitsInfo = try jsonDecoder.decode([GitCommitInfoResponse].self, from: data)
            let gitCommit = gitCommitsInfo.map({$0.commit})
            return gitCommit
        } catch {
            print("parsing error: \(error)")
            return nil
        }
    }
    
    /**
    Returns if the response from API is valid or not.

    - Parameters:
       - optionalResponse: The response to validate
     
    - Returns: The response is valid or not.
    */
    
    private func isValidResponse(optionalResponse: URLResponse?) -> Bool {
        guard let response = optionalResponse as? HTTPURLResponse, response.statusCode == 200 else { return false }
        return true
    }
}

