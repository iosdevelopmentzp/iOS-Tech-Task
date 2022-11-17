//
//  IndividAccountViewController.swift
//  
//
//  Created by Dmytro Vorko on 15/11/2022.
//

import Foundation
import UIKit
import Extensions
import MVVM
import AppResources
import AppViews

final public class IndividAccountViewController: UIViewController, View, ViewSettableType {
    // MARK: - Nested
    
    private enum Event {
        case addButtonTap
    }
    
    // MARK: - Properties
    
    public let viewModel: IndividAccountViewModel
    
    private var eventsHandler: ArgClosure<Event>?
    
    private lazy var adapter = IndividAccountViewAdapter(collectionView: collectionView, cellProvider: self, delegate: self)
    
    private lazy var layout = UICollectionViewCompositionalLayout { [weak self] in
        self?.layout(for: $0, environment: $1)
    }
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    private let buttonView = IndividAccountButton()
    
    // MARK: - Constructor
    
    public init(_ viewModel: IndividAccountViewModel) {
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
        
        collectionView.bounces = false
        
        collectionView.registerCellClass(LoadingCell.self)
        collectionView.registerCellClass(ErrorCell.self)
        collectionView.registerCellClass(IndividAccountCell.self)
    }
    
    public func setupLocalization() {
        // Localize
    }
    
    public func addViews() {
        view.addSubview(collectionView)
        view.addSubview(buttonView)
    }
    
    public func layoutViews() {
        buttonView.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            $0.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            $0.bottom.equalTo(self.buttonView.snp.top)
        }
    }
    
    public func setupOutput() {
        let output = IndividAccountViewModel.Input(
            onDidUpdateState: .init({ [weak self] in self?.update($0) })
        )
        
        viewModel.transform(output, outputHandler: self.setupInput(_:))
    }
    
    public func setupInput(_ input: IndividAccountViewModel.Output) {
        eventsHandler = {
            switch $0 {
            case .addButtonTap:
                input.onEvent(.didTapAddButton)
            }
        }
    }
}

// MARK: - Private Functions

private extension IndividAccountViewController {
    private func update(_ state: IndividAccountState) {
        adapter.update(with: state)
    }
}

// MARK: - Layout Provider

private extension IndividAccountViewController {
    private func layout(
        for section: Int,
        environment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection? {
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

// MARK: - Cell Provider

extension IndividAccountViewController: IndividAccountViewAdapterCellProvider {
    func cell(
        for collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ item: IndividAccountViewAdapter.Item
    ) -> UICollectionViewCell {
        switch item {
        case .loading:
            return collectionView.dequeueReusableCell(ofType: LoadingCell.self, at: indexPath)
            
        case .error(let message):
            let cell = collectionView.dequeueReusableCell(ofType: ErrorCell.self, at: indexPath)
            cell.configure(using: message)
            return cell
            
        case .account(let model):
            let cell = collectionView.dequeueReusableCell(ofType: IndividAccountCell.self, at: indexPath)
            cell.configure(using: model)
            return cell
        }
    }
}

// MARK: - IndividAccountViewAdapterDelegate

extension IndividAccountViewController: IndividAccountViewAdapterDelegate {
    func updateButton(_ model: IndividAccountButtonModel, animated: Bool) {
        self.buttonView.configure(using: model, animated: animated)
    }
}
