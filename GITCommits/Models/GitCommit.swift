//
//  GitCommit.swift
//  GITCommits
//
//  Created by Gabriel on 2/4/21.
//

import Foundation
import UIKit

struct Fonts {
    static let boldFont     = UIFont.preferredFont(forTextStyle: .headline)
    static let regularFont  = UIFont.preferredFont(forTextStyle: .body)
}

struct Colors {
    static let red      = UIColor.red
    static let blue     = UIColor.blue
    static let gary     = UIColor.darkGray
}

struct StringAttributes {
    static let redBold      = [NSAttributedString.Key.font : Fonts.boldFont,    NSAttributedString.Key.foregroundColor: Colors.red]
    static let blueRegular  = [NSAttributedString.Key.font : Fonts.regularFont, NSAttributedString.Key.foregroundColor: Colors.blue]
    static let garyRegular  = [NSAttributedString.Key.font : Fonts.regularFont, NSAttributedString.Key.foregroundColor: Colors.gary, NSAttributedString.Key.paragraphStyle: ParagraphStyles.defaultStyle]
}

struct ParagraphStyles {
    static var defaultStyle: NSMutableParagraphStyle {
        let paragraphStyle           = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing   = 4.0
        paragraphStyle.lineBreakMode = .byWordWrapping
        return paragraphStyle
    }
}

struct GitCommit: Decodable {
    let author: String
    let hash: String
    let message: String
    
    init(author: String, hash: String, message: String) {
        self.author     = author
        self.hash       = hash
        self.message    = message
    }
}

/// MARK:- extensions
extension GitCommit {
    func prettyString () -> NSAttributedString {
        let attribuetdString = NSMutableAttributedString(string: GenericStrings.emptyString)
        attribuetdString.append(NSAttributedString(string: formAuthorString(),   attributes: StringAttributes.redBold))
        attribuetdString.append(NSAttributedString(string: formHashString(),     attributes: StringAttributes.blueRegular))
        attribuetdString.append(NSAttributedString(string: formMessageString(),  attributes: StringAttributes.garyRegular))
        return attribuetdString
    }
    
    func formAuthorString () -> String {
        return "\(GenericStrings.author)\(self.author.trimSpaces())\(GenericStrings.doubleLine)"
    }
    
    func formHashString () -> String {
        return "\(GenericStrings.hash)\(self.hash.trimSpaces())\(GenericStrings.doubleLine)"
    }
    
    func formMessageString () -> String {
        return "\(GenericStrings.message)\(self.message.trimSpaces())"
    }
}

extension String {
    func trimSpaces () -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}

