//
//  CLRestaurantsViewController.swift
//  Restaurants
//
//  Created by Joseph Peter, Gabriel Benny Francis on 1/20/21.
//

import UIKit

class ActivityIndicatorViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showActivityIndicatorView(on parent: UIViewController) {
        parent.view.addSubview(self.view)
        spinner.startAnimating()
    }

    func removeActivityIndicatorView() {
        spinner.stopAnimating()
        self.view.removeFromSuperview()
    }
}
