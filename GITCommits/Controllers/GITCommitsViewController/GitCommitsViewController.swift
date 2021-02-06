//
//  GitCommitsViewController.swift
//  GITCommits
//
//  Created by Gabriel on 2/4/21.
//

import UIKit

struct GitCommitsViewControllerConstants {
    static let tableViewCellIdentifier = "GitCommitsCellId"
    static let activityIndicatorIdentifier = "ActivityIndicatorViewId"
}

class GitCommitsViewController: UIViewController {
    @IBOutlet weak var tblViewRecentCommits: UITableView!
    let vm = GitCommitsViewModel()
    
    lazy var spinnerView: ActivityIndicatorViewController = {
        guard let spinnerVC = self.storyboard?.instantiateViewController(identifier: GitCommitsViewControllerConstants.activityIndicatorIdentifier) as? ActivityIndicatorViewController else {
            return ActivityIndicatorViewController()
        }
        return spinnerVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    func fetchData() {
        spinnerView.showActivityIndicatorView(on: self)
        
        vm.getRecentGitCommits { [weak self] (commits, error) in
            self?.spinnerView.removeActivityIndicatorView()
            
            if commits.count > 0 {
                self?.tblViewRecentCommits.reloadData()
            }
            
            if let nError = error {
                print("Error while fetching GIT commits list : \(nError)")
            }
        }
    }
    
    func calculateCellHeight(inString: NSAttributedString) -> CGFloat
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
            let heightOfRow = self.calculateCellHeight(inString: gCommit.prettyString())
            return (heightOfRow + 60.0)
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
