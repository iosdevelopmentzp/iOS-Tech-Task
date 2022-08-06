//
//  Encodable+ToDictionary.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation

extension Encodable {
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any]?  {
        let data = try encoder.encode(self)
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}
