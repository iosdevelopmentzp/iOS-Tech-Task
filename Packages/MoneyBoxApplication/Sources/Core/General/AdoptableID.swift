//
//  AdoptableID.swift
//  
//
//  Created by Dmytro Vorko on 14/11/2022.
//

import Foundation

public struct AdoptableID {
    // MARK: - Nested
    
    private enum OriginalType {
        case int(Int)
        case string(String)
    }
    
    // MARK: - Properties
    
    private let stringFormat: String
    private let originalType: OriginalType
    
    public var value: String { stringFormat }
    
    // MARK: - Constructor
    
    public init(_ id: Int) {
        self.stringFormat = String(id)
        self.originalType = .int(id)
    }
    
    public init(_ id: String) {
        self.stringFormat = id
        self.originalType = .string(id)
    }
}

// MARK: - Codable

extension AdoptableID: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let intID = try? container.decode(Int.self) {
            self.stringFormat = String(intID)
            self.originalType = .int(intID)
        } else {
            self.stringFormat = try container.decode(String.self)
            self.originalType = .string(self.stringFormat)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        // Encode value depends on original type
        switch originalType {
        case .string(let id):
            try container.encode(id)
        case .int(let id):
            try container.encode(id)
        }
    }
}

// MARK: - Hashable

extension AdoptableID: Hashable {
    public static func == (lhs: AdoptableID, rhs: AdoptableID) -> Bool {
        lhs.stringFormat == rhs.stringFormat
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(stringFormat)
    }
}


// MARK: - Static methods

public extension AdoptableID {
    static func == (lhs: AdoptableID, rhs: String) -> Bool {
        lhs.stringFormat == rhs
    }
    
    static func == (lhs: String, rhs: AdoptableID) -> Bool {
        lhs == rhs.stringFormat
    }
    
    static func == (lhs: AdoptableID, rhs: Int) -> Bool {
        lhs.stringFormat == String(rhs)
    }
    
    static func == (lhs: Int, rhs: AdoptableID) -> Bool {
        String(lhs) == rhs.stringFormat
    }
}

