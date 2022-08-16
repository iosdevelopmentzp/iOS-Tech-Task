//
//  LoginCoordinator.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import UIKit
import SceneLogin
import DependencyResolver

final class LoginCoordinator: NavigationCoordinator {
    
    private let resolver: DependencyResolverProtocol
    
    init(_ resolver: DependencyResolverProtocol, navigation: UINavigationController) {
        self.resolver = resolver
        super.init(navigation: navigation)
    }
    
    override func start() {
        let viewController = LoginViewController(.init(useCase: resolver.resolve()))
        navigation.pushViewController(viewController, animated: true)
    }
}
