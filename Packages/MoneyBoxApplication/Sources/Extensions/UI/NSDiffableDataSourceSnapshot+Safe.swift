//
//  NSDiffableDataSourceSnapshot+Safe.swift
//  
//
//  Created by Dmytro Vorko on 14/11/2022.
//

import UIKit

public extension NSDiffableDataSourceSnapshot {
    mutating func safeAppend(_ sections: [SectionIdentifierType]) {
        assert(
            sections.isUnique,
            "New sections contains duplicated sections values. \nData source: \(self).\nSections: \(sections)"
        )
        self.appendSections(sections.unique())
    }
    
    mutating func safeAppend(_ items: [ItemIdentifierType], to section: SectionIdentifierType) {
        assert(
            items.isUnique,
            "New items contains duplicated item values. \nData source: \(self).\nItems: \(items)"
        )
        self.appendItems(items.unique(), toSection: section)
    }
}
