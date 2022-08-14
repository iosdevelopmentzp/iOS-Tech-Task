//
//  Collection+SafeSubscript.swift
//  
//
//  Created by Dmytro Vorko on 03.08.2022.
//

import Foundation

extension Collection where Index == Int {
    subscript(safe index: Index) -> Element? {
        count > 0 && (0..<count).contains(index) ? self[index] : nil
    }
}
