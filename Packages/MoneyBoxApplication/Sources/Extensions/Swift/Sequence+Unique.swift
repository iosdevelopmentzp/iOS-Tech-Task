//
//  Sequence+Unique.swift
//  
//
//  Created by Dmytro Vorko on 14/11/2022.
//

import Foundation

public extension Sequence where Iterator.Element: Hashable {
    var isUnique: Bool {
        var seen = Set<Int>()
        return allSatisfy { seen.insert($0.hashValue).inserted }
    }
    
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
