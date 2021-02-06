//
//  GCUtilities.swift
//  GITCommits
//
//  Created by Gabriel on 2/5/21.
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
