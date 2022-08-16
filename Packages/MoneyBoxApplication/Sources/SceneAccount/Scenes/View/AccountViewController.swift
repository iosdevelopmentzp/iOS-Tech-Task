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

final public class AccountViewController: UIViewController, View, ViewSettableType {
    // MARK: - Properties
    
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
        #if DEBUG
        self.navigationItem.title = "Test"
        #endif
    }
    
    // MARK: - Setup
    
    public func setupViews() {
        view.backgroundColor = UIColor.red
    }
    
    public func setupOutput() {
        viewModel.transform(.init(), outputHandler: self.setupInput(_:))
    }
    
    public func setupInput(_ input: AccountViewModel.Output) {
        
    }
}
