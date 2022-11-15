//
//  UICollectionViewDiffableDataSource+SafeGetter.swift
//  
//
//  Created by Dmytro Vorko on 15/11/2022.
//

import UIKit

public extension UICollectionViewDiffableDataSource {
    func section(by index: Int) -> SectionIdentifierType? {
        let snapshot = snapshot()
        assert(
            snapshot.sectionIdentifiers.count > index,
            "Out of bounds. Section index: \(index), identifiers: \(snapshot.sectionIdentifiers)"
        )
        return snapshot.sectionIdentifiers[safe: index]
    }
    
    func item(by indexPath: IndexPath) -> ItemIdentifierType? {
        let snapshot = snapshot()
        assert(
            snapshot.sectionIdentifiers.count > indexPath.section,
            "Out of bounds. Section index: \(indexPath.section), identifiers: \(snapshot.sectionIdentifiers)"
        )
        
        guard let section = snapshot.sectionIdentifiers[safe: indexPath.section] else {
            return nil
        }
        
        let items = snapshot.itemIdentifiers(inSection: section)
        assert(
            items.count > indexPath.row,
            "Out of bounds. Item index: \(indexPath.row), items: \(items)"
        )
        return items[safe: indexPath.row]
    }
}
