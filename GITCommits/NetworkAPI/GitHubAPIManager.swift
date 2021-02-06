//
//  GitHubAPIManager.swift
//  GITCommits
//
//  Created by Gabriel on 2/5/21.
//

import Foundation

struct GitURLConstants {
    //static let url = "https://api.github.com/repos/gabby87benny/BJKit/commits"
    static let url = "https://api.github.com/repos/apple/swift/commits"
}

struct GenericStrings {
    static let emptyString          = ""
    static let doubleLine           = "\n\n"
    static let author               = "Author:\n"
    static let hash                 = "Commit Hash:\n"
    static let message              = "Commit Message:\n"
    static let error                = "Error"
    static let cancel               = "Cancel"
    static let somethingWentWrong   = "Something went wrong, try again!"
}

struct JsonKeys {
    static let sha      = "sha"
    static let commit   = "commit"
    static let author   = "author"
    static let name     = "name"
    static let message  = "message"
}

class GitHubAPIManager {
    static let shared = GitHubAPIManager()
    typealias GenericDictionary = [String:Any]
    private let jsonDecoder = JSONDecoder()
    
    final func getRecentGitCommits(compilitionHandler: @escaping (_ list:[GitCommit]?, Error?) -> ()) {
        guard let url = URL(string: GitURLConstants.url) else { compilitionHandler(nil, nil); return }
        URLSession.shared.dataTask(with: url) { [weak self] (optionalData, optionalResponse, optionalError) in
            
            guard let strongRef = self else { compilitionHandler(nil, nil); return }
            guard optionalError == nil,
                  strongRef.isValidResponse(optionalResponse: optionalResponse),
                  let data = optionalData, let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) else { compilitionHandler(nil, nil); return }
            
            if let gCommits = strongRef.parseData(jsonResponse) {
                DispatchQueue.main.async {
                    compilitionHandler(gCommits, nil)
                }
            }
            else {
                DispatchQueue.main.async {
                    compilitionHandler(nil, nil)
                }
            }
        }.resume()
    }
    
    private func parseData (_ data: Any) -> [GitCommit]? {
        guard let jsonArr = data as? [GenericDictionary] else { return nil }
        var commitList = [GitCommit]()

        for json in jsonArr {
            guard let sha = json[JsonKeys.sha] as? String,
                  let commit = json[JsonKeys.commit] as? GenericDictionary,
                  let author = commit[JsonKeys.author] as? GenericDictionary, let name = author[JsonKeys.name] as? String,
                  let message = commit[JsonKeys.message] as? String
            else { continue }

            commitList.append(GitCommit(author: name, hash: sha, message: message))
        }

        // TODO: Filter 25 at least

        return commitList
        
        
//        do {
//            let restaurants = try jsonDecoder.decode([GitCommit].self, from: data)
//            return restaurants
//        } catch {
//            print("parsing error: \(error)")
//            return nil
//        }
    }
    
    private func isValidResponse(optionalResponse: URLResponse?) -> Bool {
        guard let response = optionalResponse as? HTTPURLResponse, response.statusCode == 200 else { return false }
        return true
    }
}

