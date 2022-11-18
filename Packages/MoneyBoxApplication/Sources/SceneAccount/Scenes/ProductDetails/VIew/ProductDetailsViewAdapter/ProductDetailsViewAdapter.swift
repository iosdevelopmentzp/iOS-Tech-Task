//
//  ProductDetailsViewAdapter.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation
import UIKit
import Extensions

// MARK: - Adapter Delegates

protocol ProductDetailsViewAdapterDelegate: AnyObject {
    func updateButton(_ model: ProductDetailsButtonModel, animated: Bool)
    func showAlert(title: String, message: String, actions: [(title: String, handler: Closure)])
}

protocol ProductDetailsViewAdapterCellProvider: AnyObject {
    func cell(
        for collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ item: ProductDetailsViewAdapter.Item
    ) -> UICollectionViewCell
}

// MARK: - ProductDetailsViewAdapter

final class ProductDetailsViewAdapter {
    // MARK: - Nested
    
    typealias Section = ProductDetailsViewSection
    typealias Item = ProductDetailsItem
    typealias CellProvider = (UICollectionView, IndexPath, Item) -> UICollectionViewCell?
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    // MARK: - Delegates
    
    private weak var delegate: ProductDetailsViewAdapterDelegate?
    
    private weak var cellProvider: ProductDetailsViewAdapterCellProvider?
    
    // MARK: - Properties
    
    let dataSource: DataSource
    
    private var state: ProductDetailsState? {
        didSet {
            guard let state = state, state != oldValue else { return }

            let snapshot = Snapshot.snapshot(from: state)
            dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
            updateButtonModel(for: state)
            invokeShowingAlertIfNeed(for: state)
        }
    }
    
    // MARK: - Constructor
    
    init(
        collectionView: UICollectionView,
        cellProvider: ProductDetailsViewAdapterCellProvider,
        delegate: ProductDetailsViewAdapterDelegate
    ) {
        self.dataSource = DataSource(collectionView: collectionView, cellProvider: {
            cellProvider.cell(for: $0, $1, $2)
        })
        collectionView.dataSource = self.dataSource
        self.delegate = delegate
    }
    
    // MARK: - Update
    
    func update(with state: ProductDetailsState) {
        self.state = state
    }
}

// MARK: - Private Functions

private extension ProductDetailsViewAdapter {
    private func invokeShowingAlertIfNeed(for newState: ProductDetailsState) {
        switch newState {
        case .idle, .loading, .loaded, .transactionLoading, .successTransaction:
            break
            
        case .failedLoading(_):
            // Message will be displayed in the collection view
            break
            
        case .failedTransaction(let errorMessage, _):
            self.delegate?.showAlert(title: "Error", message: errorMessage, actions: [("Got it", {})])
        }
    }
    
    private func updateButtonModel(for newState: ProductDetailsState) {
        var withAnimation = true
        
        if case .idle = newState {
            withAnimation = false
        }
        
        delegate?.updateButton(.Factory.make(newState), animated: withAnimation)
    }
}

// MARK: - Snapshot Factory

private extension ProductDetailsViewAdapter.Snapshot {
    static func snapshot(from state: ProductDetailsState) -> Self {
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
    
    private static func loaded(for model: ProductDetailsCellModel) -> Self {
        var snapshot = Self()
        snapshot.safeAppend([.main])
        snapshot.safeAppend([.product(model)], to: .main)
        
        return snapshot
    }
}

