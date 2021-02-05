//
//  GitCommitsViewModel.swift
//  GITCommits
//
//  Created by Gabriel on 2/5/21.
//

import Foundation

class GitCommitsViewModel {
    private var gitCommits: [GitCommit]
    typealias CompletionResult = ([GitCommit], Error?) -> ()
    
    init(gitCommits: [GitCommit] = []) {
        self.gitCommits = gitCommits
    }
    
    func getRecentGitCommits(completion: @escaping CompletionResult) {        
        GitHubAPIManager.shared.getRecentGitCommits { [weak self] gitCommits in
            if let commits = gitCommits {
                self?.gitCommits = commits
            }
        }
    }

    /**
    Returns count of recent git commits.
     
    - Returns: Number of rows.
    */
    
    func gitCommitsCount() -> Int {
        return self.gitCommits.count
    }

    /**
    Returns git commit info at indexpath.

    - Parameters:
       - indexPath: The indexpath to look for
     
    - Returns: The corresponding git commit info at indexpath.
    */
    
    func gitCommit(at indexPath: IndexPath) -> GitCommit? {
        guard indexPath.row < gitCommits.count  else { return nil }
        return gitCommits[indexPath.row]
    }

}
