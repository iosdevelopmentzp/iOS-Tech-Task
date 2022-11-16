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

final public class IndividAccountViewController: UIViewController, View, ViewSettableType {
    // MARK: - Properties
    
    public let viewModel: IndividAccountViewModel
    
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
        
        collectionView.backgroundColor = .blue
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
        // setup output
    }
    
    public func setupInput(_ input: IndividAccountViewModel.Output) {
        // setup input
    }
}

// MARK: - Layout Provider

private extension IndividAccountViewController {
    private func layout(
        for section: Int,
        environment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection? {
        nil
    }
}
