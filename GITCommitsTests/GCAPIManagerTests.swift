//
//  GCAPIManagerTests.swift
//  GITCommitsTests
//
//  Created by Gabriel on 2/7/21.
//

import XCTest
@testable import GITCommits

class GCAPIManagerTests: XCTestCase {
    var subject: GCAPIManager!
    
    override func setUpWithError() throws {
        subject = GCAPIManager()
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    /**
    Test case to validate the network fetch from GIT API is functional or not
    */
    
    func test_fetch_recent_gitcommits() {
        
        let expect = XCTestExpectation(description: "callback")

        subject.getRecentGitCommits { result in
            expect.fulfill()
            
            switch result {
                case .success(let gCommits):
                    if let gitCommits = gCommits {
                        XCTAssertGreaterThan(gitCommits.count, 0)
                        
                        for gCommit in gitCommits {
                            XCTAssertNotNil(gCommit.name)
                        }
                    }
                
                case .failure(let error):
                    print("Error: \(error)")
                    
            }
        }
        
        wait(for: [expect], timeout: 3.1)
    }

}
