//
//  NavigationCoordinator.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import UIKit

public class NavigationCoordinator: CoordinatorProtocol {
    // MARK: - Properties
    
    let navigation: UINavigationController
    public var children: [CoordinatorProtocol] = []
    public weak var parent: CoordinatorProtocol?
    
    // MARK: - Constructor
    
    public init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    // MARK: - Functions
    
    public func start() {
        fatalError("This method must be overridden")
    }
}
