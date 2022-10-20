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

class AccountHeaderView: UIView {
    
}

final public class AccountViewController: UIViewController, View, ViewSettableType {
    // MARK: - Properties
    
    private let tableView = UITableView()
    private let headerContainer = UIView()
    private let headerView = AccountHeaderView()
    
    public let viewModel: AccountViewModel
    
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
        view.backgroundColor = UIColor.red
    }
    
    public func setupLocalization() {
        navigationItem.title = Strings.Account.title
    }
    
    public func addViews() {
        view.addSubview(headerContainer)
        headerContainer.addSubview(headerView)
    }
    
    public func setupOutput() {
        viewModel.transform(.init(onDidUpdateState: { _ in }), outputHandler: self.setupInput(_:))
    }
    
    public func setupInput(_ input: AccountViewModel.Output) {
        
    }
}
