//
//  GitCommit.swift
//  GITCommits
//
//  Created by Gabriel on 2/4/21.
//

import Foundation

struct GitCommit {
    let author: String
    let hash: String
    let message: String
    
    init(author: String, hash: String, message: String) {
        self.author     = author
        self.hash       = hash
        self.message    = message
    }
}

