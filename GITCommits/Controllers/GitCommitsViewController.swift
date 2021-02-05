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
    
    let vm = GitCommitsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vm.getRecentGitCommits { (commits, error) in
            
        }
    }


}

extension GitCommitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.gitCommitsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GitCommitsViewControllerConstants.tableViewCellIdentifier, for: indexPath) as? GitCommitsTableViewCell else {
            return UITableViewCell()
        }
        
        let gCommit = vm.gitCommit(at: indexPath)
        
        return cell
    }
}
