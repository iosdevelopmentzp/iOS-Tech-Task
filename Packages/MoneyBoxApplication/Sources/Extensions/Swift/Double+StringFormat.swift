//
//  Double+StringFormat.swift
//  
//
//  Created by Dmytro Vorko on 15/11/2022.
//

import Foundation

public extension Double {
    enum StringFormat {
        case roundUp(count: Int)
        
        var format: String {
            switch self {
            case .roundUp(let places):
                return ".\(places)"
            }
        }
    }
    
    func format(_ format: StringFormat) -> String {
        String(format: "%\(format.format)f", self)
    }
}
