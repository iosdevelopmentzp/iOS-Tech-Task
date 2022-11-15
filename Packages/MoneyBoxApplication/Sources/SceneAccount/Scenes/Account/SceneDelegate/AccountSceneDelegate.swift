//
//  AccountSceneDelegate.swift
//  
//
//  Created by Dmytro Vorko on 16.08.2022.
//

import Foundation
import Core

public protocol AccountSceneDelegate: AnyObject {
    func didTapIndividualAccount(with id: AdoptableID)
}
