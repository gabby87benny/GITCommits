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

struct StringAttributes {
    static let redBold      = [NSAttributedString.Key.font : Fonts.boldFont,    NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
    static let blueRegular  = [NSAttributedString.Key.font : Fonts.regularFont, NSAttributedString.Key.foregroundColor: UIColor.orange]
    static let grayRegular  = [NSAttributedString.Key.font : Fonts.regularFont, NSAttributedString.Key.foregroundColor: UIColor.purple, NSAttributedString.Key.paragraphStyle: ParagraphStyles.defaultStyle]
}

struct ParagraphStyles {
    static var defaultStyle: NSMutableParagraphStyle {
        let paragraphStyle           = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing   = 4.0
        paragraphStyle.lineBreakMode = .byWordWrapping
        return paragraphStyle
    }
}

struct GenericStrings {
    static let emptyString          = ""
    static let doubleLine           = "\n\n"
    static let author               = "Author name:\n"
    static let hash                 = "Commit Hash:\n"
    static let message              = "Commit Message:\n"
    static let error                = "Error"
    static let cancel               = "Cancel"
    static let somethingWentWrong   = "Something went wrong, try again!"
}

