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
    private let mobileService: GCAPIManager_Protocol
    
    init(gitCommits: [GitCommit] = [], mobileService: GCAPIManager_Protocol = GCAPIManager()) {
        self.gitCommits = gitCommits
        self.mobileService = mobileService
    }
    
    /**
    Fetches data by querying the API Manager

    - Parameters:
       - completion: Completion handler
    */
    
    func getRecentGitCommits(completion: @escaping CompletionResult) {        
        self.mobileService.getRecentGitCommits { [weak self] result in
            switch result {
            case .success(let gCommits):
                if let gitCommits = gCommits {
                    self?.gitCommits = gitCommits
                    completion(gitCommits, nil)
                }
                
            case .failure(let error):
                print("Error: \(error)")
                completion([], error)
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
