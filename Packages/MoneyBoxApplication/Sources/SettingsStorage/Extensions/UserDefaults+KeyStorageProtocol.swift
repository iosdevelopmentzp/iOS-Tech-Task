//
//  UserDefaults+KeyStorageProtocol.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

extension UserDefaults: KeyStorageProtocol {
    func get<T>(key: CachingKey) -> T? where T : LosslessStringConvertible {
        self.string(forKey: key.cachingKey).flatMap { T($0) }
    }
    
    func set(key: CachingKey, value: LosslessStringConvertible?) {
        guard let value = value else {
            self.remove(key: key)
            return
        }
        self.set(value.description, forKey: key.cachingKey)
    }
    
    func remove(key: CachingKey) {
        self.removeObject(forKey: key.cachingKey)
    }
}
