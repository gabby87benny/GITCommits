//
//  FakeGCAlertPresenter.swift
//  GITCommitsTests
//
//  Created by Gabriel on 2/7/21.
//

@testable import GITCommits
import Foundation
import UIKit

class FakeGCAlertPresenter: GCAlertPresenter_Protocol {
    var present_wasCalled = false
    var present_wasCalled_withArgs: (from: UIViewController, title: String, message: String, dismissButtonTitle: String)? = nil

    func present(from: UIViewController, title: String, message: String, dismissButtonTitle: String) {
        present_wasCalled = true
        present_wasCalled_withArgs = (from: from, title: title, message: message, dismissButtonTitle: dismissButtonTitle)
    }
}

