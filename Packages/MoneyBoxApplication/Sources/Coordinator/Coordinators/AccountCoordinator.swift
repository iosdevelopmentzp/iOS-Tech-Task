//
//  AccountCoordinator.swift
//  
//
//  Created by Dmytro Vorko on 16.08.2022.
//

import Foundation
import UIKit
import SceneAccount
import DependencyResolver

final class AccountCoordinator: NavigationCoordinator {
    
    private let resolver: DependencyResolverProtocol
    
    init(_ resolver: DependencyResolverProtocol, navigation: UINavigationController) {
        self.resolver = resolver
        super.init(navigation: navigation)
    }
    
    override func start() {
        let viewModel = AccountViewModel(resolver.resolve())
        let viewController = AccountViewController(viewModel)
        viewModel.sceneDelegate = self
        navigation.setViewControllers([viewController], animated: true)
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - LoginSceneDelegate

extension AccountCoordinator: AccountSceneDelegate {
    
}
