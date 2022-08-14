//
//  LoginViewController.swift
//  
//
//  Created by Dmytro Vorko on 08.08.2022.
//

import Foundation
import AppResources
import UIKit
import MVVM
import Extensions

public final class LoginViewController: UIViewController, View, ViewSettableType {
    // MARK: - Properties
    
    public let viewModel: LoginViewModel
    
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    
    // MARK: - Constructor
    
    public init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        performSetupViews()
        setupOutput()
    }
    
    // MARK: - Setup
    
    public func setupViews() {
        view.backgroundColor = .green
    }
    
    public func setupOutput() {
        viewModel.transform(.init(), outputHandler: self.setupInput(_:))
    }
    
    public func setupInput(_ input: LoginViewModel.Output) {
        
    }
}
