//
//  FakeActivityIndicatorViewController.swift
//  GITCommitsTests
//
//  Created by Gabriel on 2/8/21.
//

@testable import GITCommits
import UIKit

class FakeActivityIndicatorViewController: ActivityIndicatorViewController {
    var activityIndicator_IsAnimating = false
    
    override func showActivityIndicatorView(on parent: UIViewController) {
        activityIndicator_IsAnimating = true
    }

    override func removeActivityIndicatorView() {
        activityIndicator_IsAnimating = false
    }
}
