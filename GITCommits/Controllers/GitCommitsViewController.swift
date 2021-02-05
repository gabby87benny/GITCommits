//
//  GitCommitsViewController.swift
//  GITCommits
//
//  Created by Gabriel on 2/4/21.
//

import UIKit

struct GitCommitsViewControllerConstants {
    static let tableViewCellIdentifier = "GitCommitsCellId"
}

class GitCommitsViewController: UIViewController {

    @IBOutlet weak var tblViewRecentCommits: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension GitCommitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GitCommitsViewControllerConstants.tableViewCellIdentifier, for: indexPath) as? GitCommitsTableViewCell else {
            return UITableViewCell()
        }
        

        return cell
    }
}
