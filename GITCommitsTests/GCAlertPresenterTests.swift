//
//  GITCommitsTests.swift
//  GITCommitsTests
//
//  Created by Gabriel on 2/4/21.
//

import XCTest
@testable import GITCommits

class GCAlertPresenterTests: XCTestCase {
    var fakeViewController: PartiallyFakeViewController!
    var subject: GCAlertPresenter_Protocol!

    override func setUpWithError() throws {
        fakeViewController = PartiallyFakeViewController()
        subject = GCAlertPresenter()
    }

    override func tearDownWithError() throws {
        fakeViewController = nil
        subject = nil
    }
    
    /**
    Test case to validate if view controller presents the alert controller
    */
    
    func testPresent_tellsTheViewControllerToPresentAnAlertController() {
        subject.present(from: fakeViewController, title: "", message: "", dismissButtonTitle: "")
        XCTAssertTrue(fakeViewController.present_wasCalled)
        XCTAssertTrue(fakeViewController.present_wasCalled_withArgs?.viewControllerToPresent is UIAlertController)
    }

    /**
    Test case to validate if callback is nil while presenting alert from view controller
    */
    
    func testPresent_doesNotConfigureCallbackForPresentation() {
        subject.present(from: fakeViewController, title: "", message: "", dismissButtonTitle: "")
        XCTAssertNil(fakeViewController.present_wasCalled_withArgs?.completion)
    }

    /**
    Test case to validate if alert controller displays test title and message
    */
    
    func testPresent_configuresTheAlertWithTitleAndMessage() {
        subject.present(from: fakeViewController, title: "Some alert title", message: "Detailed message", dismissButtonTitle: "")

        let alertController = fakeViewController.present_wasCalled_withArgs?.viewControllerToPresent as? UIAlertController
        XCTAssertEqual(alertController?.title, "Some alert title")
        XCTAssertEqual(alertController?.message, "Detailed message")
    }
}
