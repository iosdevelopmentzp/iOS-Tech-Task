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
}

public extension ViewSettableType {
    func performSetupViews() {
        setupViews()
        setupLocalization()
        addViews()
        layoutViews()
    }
    
    func setupViews() {
        // Default Implementation
    }
    
    func setupLocalization() {
        
    }
    
    func addViews() {
        // Default Implementation
    }
    
    func layoutViews() {
        // Default Implementation
    }
}
