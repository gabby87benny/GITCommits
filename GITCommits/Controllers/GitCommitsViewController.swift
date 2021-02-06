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
            if commits.count > 0 {
                self.tblViewRecentCommits.reloadData()
            }
            
            if let nError = error {
                print("Error while fetching restaurants list : \(nError)")
            }
        }
    }

    func calculateHeight(inString: NSAttributedString) -> CGFloat
    {
        let rect : CGRect = inString.boundingRect(with: CGSize(width: tblViewRecentCommits.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        return rect.height
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
        cell.gitCommit = gCommit
        return cell
    }
}

extension GitCommitsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let gCommit = vm.gitCommit(at: indexPath) {
            let heightOfRow = self.calculateHeight(inString: gCommit.prettyString())
            return (heightOfRow + 60.0)
        }
        
        return UITableView.automaticDimension
    }
}
