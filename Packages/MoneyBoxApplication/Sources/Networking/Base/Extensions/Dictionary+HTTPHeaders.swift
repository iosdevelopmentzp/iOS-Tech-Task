//
//  Dictionary+HTTPHeaders.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation
import Alamofire

extension Dictionary where Key == String, Value == String {
    var asHTTPHeaders: HTTPHeaders? {
        guard !self.isEmpty else { return nil }
        return .init(self.map { HTTPHeader(name: $0.key, value: $0.value) })
    }
}
