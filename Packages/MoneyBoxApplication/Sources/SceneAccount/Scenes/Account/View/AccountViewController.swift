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
    // MARK: - Properties
    
    public let viewModel: AccountViewModel
    
    private lazy var adapter = AccountViewAdapter(collectionView: collectionView) { [weak self] in
        self?.cellProvider($0, $1, $2) ?? UICollectionViewCell()
    }
    
    private lazy var layout = UICollectionViewCompositionalLayout.init { [weak self] section, environment in
        self?.layout(for: section, environment: environment)
    }
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
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
        
        collectionView.registerCellClass(LoadingCell.self)
        collectionView.registerCellClass(ErrorCell.self)
        collectionView.registerCellClass(AccountHeaderCell.self)
        collectionView.registerCellClass(AccountCell.self)
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
        viewModel.transform(output) { self.setupInput($0) }
    }
    
    public func setupInput(_ input: AccountViewModel.Output) {
        
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
            return cell
            
        case .header(let viewModel):
            let cell = collectionView.dequeueReusableCell(ofType: AccountHeaderCell.self, at: indexPath)
            cell.configure(using: viewModel)
            return cell
            
        case .account(let viewModel):
            let cell = collectionView.dequeueReusableCell(ofType: AccountCell.self, at: indexPath)
            cell.configure(using: viewModel)
            return cell
        }
    }
}
