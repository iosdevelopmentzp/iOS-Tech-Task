//
//  AccountViewAdapter.swift
//  
//
//  Created by Dmytro Vorko on 14/11/2022.
//

import UIKit
import Extensions

enum AccountViewSection {
    /// A section for displaying a single item such as loading or error UI
    case single
    
    case main
}

enum AccountViewItem: Hashable {
    case loading
    case error(_ message: String)
    case header(_ model: AccountHeaderCellModel)
    case account(_ model: AccountCellModel)
}

final class AccountViewAdapter {
    // MARK: - Netsted
    
    typealias Section = AccountViewSection
    typealias Item = AccountViewItem
    typealias CellProvider = (UICollectionView, IndexPath, Item) -> UICollectionViewCell?
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    // MARK: - Properties
    
    let dataSource: DataSource
    
    private var state: AccountState? {
        didSet {
            guard let state = state, state != oldValue else { return }

            let snapshot = Snapshot.snapshot(from: state)
            dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
        }
    }
    
    // MARK: - Constructor
    
    init(collectionView: UICollectionView, cellProvider: @escaping CellProvider) {
        self.dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        collectionView.dataSource = self.dataSource
    }
    
    // MARK: - Update
    
    func update(with state: AccountState) {
        self.state = state
    }
}

private extension AccountViewAdapter.Snapshot {
    static func snapshot(from state: AccountState) -> Self {
        switch state {
        case .loading, .idle:
            return loading()
        
        case .loaded(let items):
            return loaded(for: items)
            
        case .failed(let message):
            return error(message)
        }
    }
    
    private static func loading() -> Self {
        var snapshot = Self()
        snapshot.safeAppend([.single])
        snapshot.safeAppend([.loading], to: .single)
        return snapshot
    }
    
    private static func error(_ message: String) -> Self {
        var snapshot = Self()
        snapshot.safeAppend([.single])
        snapshot.safeAppend([.error(message)], to: .single)
        return snapshot
    }
    
    private static func loaded(for items: [AccountItem]) -> Self {
        var snapshot = Self()
        snapshot.safeAppend([.main])
        
        let snapshotItems: [AccountViewAdapter.Item] = items.map {
            switch $0 {
            case .individualAccount(let viewModel):
                return .account(viewModel)
                
            case .header(let viewModel):
                return .header(viewModel)
            }
        }
        
        snapshot.safeAppend(snapshotItems, to: .main)
        
        return snapshot
    }
}

