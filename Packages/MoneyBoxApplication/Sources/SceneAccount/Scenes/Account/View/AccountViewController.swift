//
//  AccountViewController.swift
//  
//
//  Created by Dmytro Vorko on 16.08.2022.
//

import Foundation
import UIKit
import MVVM
import Extensions
import AppResources
import SnapKit
import AppViews

final public class AccountViewController: UIViewController, View, ViewSettableType {
    // MARK: Nested
    
    private enum Event {
        case productTap(_ id: Int)
        case retryButtonTap
    }
    
    // MARK: - Properties
    
    public let viewModel: AccountViewModel
    
    private lazy var adapter = AccountViewAdapter(collectionView: collectionView) { [weak self] in
        self?.cellProvider($0, $1, $2) ?? UICollectionViewCell()
    }
    
    private lazy var layout = UICollectionViewCompositionalLayout.init { [weak self] section, environment in
        self?.layout(for: section, environment: environment)
    }
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    private var eventsHandler: ArgClosure<Event>?
    
    // MARK: - Constructor
    
    public init(_ viewModel: AccountViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        performSetupViews()
        setupOutput()
    }
    
    // MARK: - Setup
    
    public func setupViews() {
        view.backgroundColor = Colors.Background.screenBackground.color
        
        collectionView.delegate = self
        
        collectionView.registerCellClass(LoadingCell.self)
        collectionView.registerCellClass(ErrorCell.self)
        collectionView.registerCellClass(AccountHeaderCell.self)
        collectionView.registerCellClass(ProductCell.self)
    }
    
    public func setupLocalization() {
        navigationItem.title = Strings.Account.title
    }
    
    public func addViews() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    public func setupOutput() {
        let output = AccountViewModel.Input(
            onDidUpdateState: .init { [weak self] in self?.updateState($0) }
        )
        viewModel.transform(output, outputHandler: self.setupInput(_:))
    }
    
    public func setupInput(_ input: AccountViewModel.Output) {
        eventsHandler = {
            switch $0 {
            case .productTap(let id):
                input.onEvent(.didTapproduct(id))
                
            case .retryButtonTap:
                input.onEvent(.retryButtonTap)
            }
        }
    }
}

// MARK: - Private

private extension AccountViewController {
    private func updateState(_ state: AccountState) {
        adapter.update(with: state)
    }
}

// MARK: - Layout Provider

private extension AccountViewController {
    private func layout(for section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        guard let sectionIdentifier = adapter.dataSource.section(by: section) else {
            return nil
        }
        
        switch sectionIdentifier {
        case .single, .main:
            let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let item = NSCollectionLayoutSupplementaryItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
            return .init(group: group)
        }
    }
}

// MARK: - Data Source Provider

private extension AccountViewController {
    private func cellProvider(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ item: AccountViewAdapter.Item
    ) -> UICollectionViewCell {
        switch item {
        case .loading:
            let cell = collectionView.dequeueReusableCell(ofType: LoadingCell.self, at: indexPath)
            return cell
            
        case .error(let message):
            let cell = collectionView.dequeueReusableCell(ofType: ErrorCell.self, at: indexPath)
            cell.configure(using: message)
            cell.delegate = self
            return cell
            
        case .header(let viewModel):
            let cell = collectionView.dequeueReusableCell(ofType: AccountHeaderCell.self, at: indexPath)
            cell.configure(using: viewModel)
            return cell
            
        case .product(let viewModel):
            let cell = collectionView.dequeueReusableCell(ofType: ProductCell.self, at: indexPath)
            cell.configure(using: viewModel)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension AccountViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = adapter.dataSource.item(by: indexPath) else { return }
        
        switch item {
        case .loading, .error, .header:
            assertionFailure("Unexpected item")
        
        case .product(let viewModel):
            eventsHandler?(.productTap(viewModel.id))
        }
    }
}

// MARK: - ErrorCellEventsDelegate

extension AccountViewController: ErrorCellEventsDelegate {
    public func cell(_ cell: ErrorCell, didPressRetryButton sender: UIButton) {
        eventsHandler?(.retryButtonTap)
    }
}
