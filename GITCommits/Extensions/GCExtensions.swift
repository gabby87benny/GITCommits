//
//  GCExtensions.swift
//  GITCommits
//
//  Created by Gabriel on 2/5/21.
//

import Foundation

extension String {
    func trimSpaces () -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension Collection {
    subscript(safeUnwrap index: Index) -> Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
