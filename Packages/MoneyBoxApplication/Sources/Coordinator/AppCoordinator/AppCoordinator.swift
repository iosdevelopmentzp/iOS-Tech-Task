//
//  AppCoordinator.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import DependencyResolver
import UIKit

public final class AppCoordinator: NavigationCoordinator {
    // MARK: - Properties
    
    private let window: UIWindow
    
    private let resolver: DependencyResolverProtocol
    
    // MARK: - Constructor
    
    public init(window: UIWindow, resolver: DependencyResolverProtocol) {
        self.window = window
        self.resolver = resolver
        let navigationController = UINavigationController()
        navigationController.view.backgroundColor = .white
        super.init(navigation: navigationController)
    }
    
    // MARK: - Constructor
    
    public override func start() {
        window.rootViewController = navigation
        let loginCoordinator = LoginCoordinator(resolver, navigation: navigation)
        addChild(loginCoordinator)
        loginCoordinator.start()
        window.makeKeyAndVisible()
    }
}
