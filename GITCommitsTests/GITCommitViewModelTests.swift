//
//  GITCommitViewModelTests.swift
//  GITCommitsTests
//
//  Created by Gabriel on 2/7/21.
//

import XCTest
@testable import GITCommits

class GITCommitViewModelTests: XCTestCase {
    var subject: GitCommitsViewModel!
    var mockAPIManager: FakeGCAPIManager!
    
    override func setUpWithError() throws {
        mockAPIManager = FakeGCAPIManager()
        subject = GitCommitsViewModel(mobileService: mockAPIManager)
    }

    override func tearDownWithError() throws {
        mockAPIManager = nil
        subject = nil
    }

    /**
    Test case to validate if data fetch method from API manager is called
    */
    
    func test_fetch_gitCommits() {
        subject.getRecentGitCommits { (gitCommits, error) in
            
        }
        XCTAssertTrue(mockAPIManager!.githubAPI_wasCalled)
    }
}
