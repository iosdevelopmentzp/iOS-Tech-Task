//
//  ProductDetailsViewController.swift
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

final public class ProductDetailsViewController: UIViewController, View, ViewSettableType {
    // MARK: - Nested
    
    private enum Event {
        case addButtonTap
        case retryButtonTap
    }
    
    // MARK: - Properties
    
    public let viewModel: ProductDetailsViewModel
    
    private var eventsHandler: ArgClosure<Event>?
    
    private lazy var adapter = ProductDetailsViewAdapter(collectionView: collectionView, cellProvider: self, delegate: self)
    
    private lazy var layout = UICollectionViewCompositionalLayout { [weak self] in
        self?.layout(for: $0, environment: $1)
    }
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    private let buttonView = ProductDetailsButton()
    
    // MARK: - Constructor
    
    public init(_ viewModel: ProductDetailsViewModel) {
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
        collectionView.registerCellClass(ProductDetailsCell.self)
        
        buttonView.delegate = self
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
        let output = ProductDetailsViewModel.Input(
            onDidUpdateState: .init({ [weak self] in self?.update($0) })
        )
        
        viewModel.transform(output, outputHandler: self.setupInput(_:))
    }
    
    public func setupInput(_ input: ProductDetailsViewModel.Output) {
        eventsHandler = {
            switch $0 {
            case .addButtonTap:
                input.onEvent(.didTapAddButton)
                
            case .retryButtonTap:
                input.onEvent(.didTapRetryButton)
            }
        }
    }
}

// MARK: - Private Functions

private extension ProductDetailsViewController {
    private func update(_ state: ProductDetailsState) {
        adapter.update(with: state)
    }
}

// MARK: - Layout Provider

private extension ProductDetailsViewController {
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

extension ProductDetailsViewController: ProductDetailsViewAdapterCellProvider {
    func cell(
        for collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ item: ProductDetailsViewAdapter.Item
    ) -> UICollectionViewCell {
        switch item {
        case .loading:
            return collectionView.dequeueReusableCell(ofType: LoadingCell.self, at: indexPath)
            
        case .error(let message):
            let cell = collectionView.dequeueReusableCell(ofType: ErrorCell.self, at: indexPath)
            cell.configure(using: message)
            cell.delegate = self
            return cell
            
        case .account(let model):
            let cell = collectionView.dequeueReusableCell(ofType: ProductDetailsCell.self, at: indexPath)
            cell.configure(using: model)
            return cell
        }
    }
}

// MARK: - IndividAccountViewAdapterDelegate

extension ProductDetailsViewController: ProductDetailsViewAdapterDelegate {
    func showAlert(title: String, message: String, actions: [(title: String, handler: Closure)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { tuple in
            let action = UIAlertAction(title: tuple.title, style: .default, handler: { _ in tuple.handler() })
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }
    
    func updateButton(_ model: ProductDetailsButtonModel, animated: Bool) {
        self.buttonView.configure(using: model, animated: animated)
    }
}

// MARK: - ErrorCellEventsDelegate

extension ProductDetailsViewController: ErrorCellEventsDelegate {
    public func cell(_ cell: ErrorCell, didPressRetryButton sender: UIButton) {
        eventsHandler?(.retryButtonTap)
    }
}

// MARK: - IndividAccountButtonDelegate
 
extension ProductDetailsViewController: IndividAccountButtonDelegate {
    func didTapButton(_ buttonView: ProductDetailsButton, _ sender: UIButton) {
        eventsHandler?(.addButtonTap)
    }
}
