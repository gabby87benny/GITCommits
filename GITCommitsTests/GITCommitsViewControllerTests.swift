//
//  GITCommitsTests.swift
//  GITCommitsTests
//
//  Created by Gabriel on 2/4/21.
//

import XCTest
@testable import GITCommits

class GITCommitsViewControllerTests: XCTestCase {
    var sut: GitCommitsViewController!
    var alertPresenter: FakeGCAlertPresenter!
    var viewModel: FakeGitCommitsViewModel!
    var spinner: FakeActivityIndicatorViewController = FakeActivityIndicatorViewController()
    
    override func setUpWithError() throws {
        alertPresenter = FakeGCAlertPresenter()
        viewModel = FakeGitCommitsViewModel()
        sut = GitCommitsViewController(viewModel: viewModel, alertPresenter: alertPresenter)
        sut.spinnerView = spinner
    }

    override func tearDownWithError() throws {
        alertPresenter = nil
        viewModel = nil
        sut = nil
    }

    /**
    Test case to validate if view has loaded
    */
    
    func testIfViewIsLoaded() {
        XCTAssertNotNil(sut.view)
    }
    
    /**
    Test case to validate if spinner is displayed when view has loaded
    */
    
    func testIfSpinnerIsLoadingWhileViewLoad() {
        XCTAssertNotNil(sut.view)
        XCTAssertTrue(spinner.activityIndicator_IsAnimating)
    }
    
    /**
    Test case to validate if data fetch happens when view has loaded
    */
    
    func testIfDataFetchHappensWhileViewLoad() {
        XCTAssertNotNil(sut.view)
        XCTAssertTrue(viewModel.gitCommitModel_wasCalled)
    }
}
