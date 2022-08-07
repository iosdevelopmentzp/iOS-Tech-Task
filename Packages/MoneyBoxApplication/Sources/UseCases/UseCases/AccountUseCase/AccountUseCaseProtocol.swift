//
//  AccountUseCaseProtocol.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

public protocol AccountUseCaseProtocol {
    func products() async throws -> [Int]
}
