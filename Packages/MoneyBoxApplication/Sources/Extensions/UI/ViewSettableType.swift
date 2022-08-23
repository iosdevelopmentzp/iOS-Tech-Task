//
//  ViewSettableType.swift
//  
//
//  Created by Dmytro Vorko on 03.08.2022.
//

import Foundation

public protocol ViewSettableType {
    func setupViews()
    func setupLocalization()
    func addViews()
    func layoutViews()
    func setupViewLinks()
}

public extension ViewSettableType {
    func performSetupViews() {
        setupViews()
        setupLocalization()
        addViews()
        layoutViews()
        setupViewLinks()
    }
    
    /// To customizing your views
    func setupViews() {
        // Default Implementation
    }
    
    /// To setup localized strings
    func setupLocalization() {
        // Default Implementation
    }
    
    /// To add views to them parents
    func addViews() {
        // Default Implementation
    }
    
    /// Set your views constraints
    func layoutViews() {
        // Default Implementation
    }
    
    /// To link your views with delegate, add targets and actions, etc.
    func setupViewLinks() {
        // Default Implementation
    }
}
