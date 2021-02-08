//
//  FakeGitCommitsViewModel.swift
//  GITCommitsTests
//
//  Created by Gabriel on 2/7/21.
//

@testable import GITCommits
import Foundation
import UIKit

class FakeGitCommitsViewModel: GitCommitsViewModel {
    typealias CompletionResult = ([GitCommit], Error?) -> ()
    var gitCommitModel_wasCalled = false
    var gitCommitModel_wasCalled_withCompletion: CompletionResult?
    
    override func getRecentGitCommits(completion: @escaping CompletionResult) {
        gitCommitModel_wasCalled = true
        gitCommitModel_wasCalled_withCompletion = completion
    }
}
