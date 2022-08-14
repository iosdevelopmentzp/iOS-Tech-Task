//
//  LoginCoordinator.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import UIKit
import SceneLogin

final class LoginCoordinator: NavigationCoordinator {
    override func start() {
        let viewController = LoginViewController(.init())
        navigation.pushViewController(viewController, animated: true)
    }
}
