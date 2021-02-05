//
//  GitHubAPIManager.swift
//  GITCommits
//
//  Created by Gabriel on 2/5/21.
//

import Foundation

struct GitURLConstants {
    static let url = "https://api.github.com"
}


class GitHubAPIManager {
    static let shared = GitHubAPIManager()
    
    final func getRecentGitCommits(compilitionHandler: @escaping (_ list:[GitCommit]?) -> ()) {
       
        
    }
}
