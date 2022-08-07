//
//  KeyStorageProtocol.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

protocol KeyStorageProtocol {
    func get<T: LosslessStringConvertible>(key: CachingKey) -> T?

    func set(key: CachingKey, value: LosslessStringConvertible?)

    func remove(key: CachingKey)
}
