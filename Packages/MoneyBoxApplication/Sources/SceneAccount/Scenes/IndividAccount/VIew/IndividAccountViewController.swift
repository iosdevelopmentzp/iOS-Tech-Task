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

final public class IndividAccountViewController: UIViewController, View, ViewSettableType {
    // MARK: - Properties
    
    public let viewModel: IndividAccountViewModel
    
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
        // Setup
    }
    
    public func setupLocalization() {
        // Localize
    }
    
    public func addViews() {
        // add views
    }
    
    public func setupOutput() {
        // setup output
    }
    
    public func setupInput(_ input: IndividAccountViewModel.Output) {
        // setup input
    }
}
