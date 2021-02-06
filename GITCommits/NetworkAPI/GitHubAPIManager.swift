//
//  GitHubAPIManager.swift
//  GITCommits
//
//  Created by Gabriel on 2/5/21.
//

import Foundation

struct GitURLConstants {
    static let url = "https://api.github.com/repos/apple/swift/commits"
}

class GitHubAPIManager {
    static let shared = GitHubAPIManager()
    typealias GenericDictionary = [String:Any]
    private let jsonDecoder = JSONDecoder()
    
    final func getRecentGitCommits(completionHandler: @escaping (_ list:[GitCommit]?, Error?) -> ()) {
        guard let url = URL(string: GitURLConstants.url) else { completionHandler(nil, nil); return }
        URLSession.shared.dataTask(with: url) { [weak self] (optionalData, optionalResponse, optionalError) in
            guard let strongRef = self else { completionHandler(nil, nil); return }
            guard optionalError == nil,
                  strongRef.isValidResponse(optionalResponse: optionalResponse),
                  let data = optionalData else { completionHandler(nil, nil); return }
            
            if let gCommits = strongRef.parseData(data) {
                DispatchQueue.main.async {
                    completionHandler(gCommits, nil)
                }
            }
            else {
                DispatchQueue.main.async {
                    completionHandler(nil, nil)
                }
            }
        }.resume()
    }
    
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
    
    private func isValidResponse(optionalResponse: URLResponse?) -> Bool {
        guard let response = optionalResponse as? HTTPURLResponse, response.statusCode == 200 else { return false }
        return true
    }
}

