//
//  FakeGCAPIManager.swift
//  GITCommitsTests
//
//  Created by Gabriel on 2/7/21.
//

import Foundation
@testable import GITCommits

class FakeGCAPIManager: GCAPIManager_Protocol {
    var githubAPI_wasCalled = false
    var githubAPI_wasCalled_withCompletion: QueryResult?
    
    final func getRecentGitCommits(completionHandler: @escaping QueryResult) {
        githubAPI_wasCalled = true
        githubAPI_wasCalled_withCompletion = completionHandler
    }
}
