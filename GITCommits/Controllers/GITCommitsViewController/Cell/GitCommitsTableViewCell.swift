//
//  GitCommitsTableViewCell.swift
//  GITCommits
//
//  Created by Gabriel on 2/5/21.
//

import UIKit

class GitCommitsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblGitCommitInfo: UILabel!

    var gitCommit: GitCommit? {
        didSet {
            if let gCommit = gitCommit {
                self.lblGitCommitInfo.attributedText = gCommit.prettyString()
            }
        }
    }
}
