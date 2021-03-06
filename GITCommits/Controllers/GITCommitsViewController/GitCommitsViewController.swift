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
    
    private var gcViewModel : GitCommitsViewModel
    private var alertPresenter: GCAlertPresenter_Protocol
    
    var spinnerView: ActivityIndicatorViewController?

    init(viewModel: GitCommitsViewModel = GitCommitsViewModel(), alertPresenter: GCAlertPresenter_Protocol = GCAlertPresenter()) {
        self.gcViewModel = viewModel
        self.alertPresenter = alertPresenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.gcViewModel = GitCommitsViewModel()
        self.alertPresenter = GCAlertPresenter()
        super.init(coder: coder)
    }
    
    func initializeSpinner() {
        guard let spinnerVC = self.storyboard?.instantiateViewController(identifier: GitCommitsViewControllerConstants.activityIndicatorIdentifier) as? ActivityIndicatorViewController else {
            return
        }
        self.spinnerView = spinnerVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSpinner()
        fetchRecentGitCommits()
    }

    /**
    Fetches recent git commits data on view load.
    */
    
    func fetchRecentGitCommits() {
        spinnerView?.showActivityIndicatorView(on: self)
        
        gcViewModel.getRecentGitCommits { [weak self] (commits, error) in
            self?.spinnerView?.removeActivityIndicatorView()
            
            if commits.count > 0 {
                self?.tblViewRecentCommits.reloadData()
            }
            
            if let nError = error {
                print("Error while fetching GIT commits list : \(nError)")
                guard let self = self else { return }
                self.alertPresenter.present(from: self,
                                            title: "Error",
                                            message: "Github API service is failed.",
                                            dismissButtonTitle: "OK")
            }
        }
    }
    
    /**
    Returns height of table view cell based on text.

    - Parameters:
       - inString: The attributed string input
     
    - Returns: The height value of cell
    */
    
    func calculateCellHeight(inString: NSAttributedString) -> CGFloat
    {
        let rect : CGRect = inString.boundingRect(with: CGSize(width: tblViewRecentCommits.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        return rect.height
    }
}

//MARK: Table view data source

extension GitCommitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gcViewModel.gitCommitsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GitCommitsViewControllerConstants.tableViewCellIdentifier, for: indexPath) as? GitCommitsTableViewCell else {
            return UITableViewCell()
        }
        
        let gCommit = gcViewModel.gitCommit(at: indexPath)
        cell.gitCommit = gCommit
        return cell
    }
}

//MARK: Table view delegates

extension GitCommitsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let gCommit = gcViewModel.gitCommit(at: indexPath) {
            let heightOfRow = self.calculateCellHeight(inString: gCommit.prettyString())
            return (heightOfRow + 60.0)
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
