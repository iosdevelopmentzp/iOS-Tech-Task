//
//  DataRequest+ValidStatusCode.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import Alamofire

extension DataRequest {
    // MARK: - Functions
    
    func validate<R: Decodable>(validStatusCode: [Int], expectedType: R.Type, decoder: JSONDecoder) -> Self {
        self.validate { _, response, data in
            switch response.statusCode {
            case let statusCode where validStatusCode.contains(statusCode):
                return .success(())
                
            case let statusCode:
                let decodedModel = data.flatMap { try? decoder.decode(expectedType, from: $0) }
                let error = decodedModel.map {
                    InvalidStatusCodeResponse.withDecodedModel($0, statusCode)
                } ?? InvalidStatusCodeResponse.code(statusCode)
                return .failure(error)
            }
        }
    }
}

enum InvalidStatusCodeResponse: LocalizedError {
    case code(Int)
    case withDecodedModel(_ model: Decodable, _ code: Int)
    
    var errorDescription: String? {
        switch self {
        case .code(let code):
            return "Https error code: \(code)"
            
        case .withDecodedModel(let decoded, _) where decoded is Error:
            return (decoded as? Error)?.localizedDescription ?? ""
            
        case .withDecodedModel(_, let code):
            return "Https error code: \(code)"
        }
    }
}
