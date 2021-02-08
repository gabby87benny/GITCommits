//
//  GitCommit.swift
//  GITCommits
//
//  Created by Gabriel on 2/4/21.
//

import Foundation

struct GitCommitInfoResponse: Decodable {
    var commit: GitCommit
}

struct GitCommit: Decodable {
    let name: String
    let hash: String
    let message: String
    
    enum RootCodingKeys: String, CodingKey {
        case author
        case message
        case tree
    }
    
    enum AuthorCodingKeys: String, CodingKey {
        case name
        case email
        case date
    }
    
    enum TreeCodingKeys: String, CodingKey {
        case hash = "sha"
        case url
    }
    
    enum CommitInfoCodingKeys: String, CodingKey {
        case author
        case message
        case tree
    }
}

/// MARK:- Extensions

extension GitCommit {
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        
        let authorInfoContainer = try rootContainer.nestedContainer(keyedBy: AuthorCodingKeys.self, forKey: .author)
        self.name = try authorInfoContainer.decode(String.self, forKey: .name)
        
        let treeInfoContainer = try rootContainer.nestedContainer(keyedBy: TreeCodingKeys.self, forKey: .tree)
        self.hash = try treeInfoContainer.decode(String.self, forKey: .hash)
        
        self.message = try rootContainer.decode(String.self, forKey: .message)
    }
}

extension GitCommit {
    func prettyString () -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: GenericStrings.emptyString)
        attributedString.append(NSAttributedString(string: formAuthorString(),   attributes: StringAttributes.redBold))
        attributedString.append(NSAttributedString(string: formHashString(),     attributes: StringAttributes.blueRegular))
        attributedString.append(NSAttributedString(string: formMessageString(),  attributes: StringAttributes.grayRegular))
        return attributedString
    }
    
    func formAuthorString () -> String {
        return "\(GenericStrings.author)\(self.name.trimSpaces())\(GenericStrings.doubleLine)"
    }
    
    func formHashString () -> String {
        return "\(GenericStrings.hash)\(self.hash.trimSpaces())\(GenericStrings.doubleLine)"
    }
    
    func formMessageString () -> String {
        return "\(GenericStrings.message)\(self.message.trimSpaces())"
    }
}

