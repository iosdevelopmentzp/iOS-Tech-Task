//
//  AccountUseCaseProtocol.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import Core

public protocol AccountUseCaseProtocol {
    func userAccount() async throws -> UserAccount
}
