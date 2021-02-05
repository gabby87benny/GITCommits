//
//  GitHubAPIManager.swift
//  GITCommits
//
//  Created by Gabriel on 2/5/21.
//

import Foundation

struct GitURLConstants {
    static let url = "https://api.github.com/repos/gabby87benny/BJKit/commits"
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
    
    final func getRecentGitCommits(compilitionHandler: @escaping (_ list:[GitCommit]?) -> ()) {
        guard let url = URL(string: GitURLConstants.url) else { compilitionHandler(nil); return }
        URLSession.shared.dataTask(with: url) { [weak self] (optionalData, optionalResponse, optionalError) in
            guard let strongRef = self else { compilitionHandler(nil); return }
            guard optionalError == nil,
                  strongRef.isResponseOk(optionalResponse: optionalResponse),
                  let data = optionalData, let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) else { compilitionHandler(nil); return }
            compilitionHandler(strongRef.parseData(jsonResponse))
        }.resume()
    }
    
    private func parseData (_ jsonResponse: Any) -> [GitCommit]? {
        guard let jsonArr = jsonResponse as? [GenericDictionary] else { return nil }
        
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
    }
    
    private func isResponseOk (optionalResponse: URLResponse?) -> Bool {
        guard let response = optionalResponse as? HTTPURLResponse, response.statusCode == 200 else { return false }
        return true
    }
}

