//
//  IndividAccountViewAdapter.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation
import UIKit
import Extensions

// MARK: - Adapter Delegates

protocol IndividAccountViewAdapterDelegate: AnyObject {
    func updateButton(_ model: IndividAccountButtonModel, animated: Bool)
}

protocol IndividAccountViewAdapterCellProvider: AnyObject {
    func cell(
        for collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ item: IndividAccountViewAdapter.Item
    ) -> UICollectionViewCell
}

// MARK: - IndividAccountViewAdapter

final class IndividAccountViewAdapter {
    // MARK: - Nested
    
    typealias Section = IndividAccountViewSection
    typealias Item = IndividAccountItem
    typealias CellProvider = (UICollectionView, IndexPath, Item) -> UICollectionViewCell?
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    // MARK: - Delegates
    
    private weak var delegate: IndividAccountViewAdapterDelegate?
    
    private weak var cellProvider: IndividAccountViewAdapterCellProvider?
    
    // MARK: - Properties
    
    let dataSource: DataSource
    
    private var state: IndividAccountState? {
        didSet {
            guard let state = state, state != oldValue else { return }

            let snapshot = Snapshot.snapshot(from: state)
            dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
            updateButtonModel(for: state)
        }
    }
    
    // MARK: - Constructor
    
    init(
        collectionView: UICollectionView,
        cellProvider: IndividAccountViewAdapterCellProvider,
        delegate: IndividAccountViewAdapterDelegate
    ) {
        self.dataSource = DataSource(collectionView: collectionView, cellProvider: {
            cellProvider.cell(for: $0, $1, $2)
        })
        collectionView.dataSource = self.dataSource
        self.delegate = delegate
    }
    
    // MARK: - Update
    
    func update(with state: IndividAccountState) {
        self.state = state
    }
}

// MARK: - Private Functions

private extension IndividAccountViewAdapter {
    private func updateButtonModel(for newState: IndividAccountState) {
        var withAnimation = true
        
        if case .idle = newState {
            withAnimation = false
        }
        
        delegate?.updateButton(.Factory.make(newState), animated: withAnimation)
    }
}

// MARK: - Snapshot Factory

private extension IndividAccountViewAdapter.Snapshot {
    static func snapshot(from state: IndividAccountState) -> Self {
        switch state {
        case .idle, .loading:
            return loading()
            
        case .failedLoading(let errorMessage):
            return error(errorMessage)
            
        case .loaded(let model),
                .transactionLoading(let model),
                .failedTransaction(_, let model),
                .successTransaction(let model):
            return loaded(for: .Factory.make(model: model))
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
    
    private static func loaded(for model: IndividAccountCellModel) -> Self {
        var snapshot = Self()
        snapshot.safeAppend([.main])
        snapshot.safeAppend([.account(model)], to: .main)
        
        return snapshot
    }
}

