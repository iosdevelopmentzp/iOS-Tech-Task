//
//  NetworkLogListener.swift
//  
//
//  Created by Dmytro Vorko on 21/10/2022.
//

import Foundation

private typealias JSON = Dictionary<String, Any>

class NetworkLogListener: NetworkListenerProtocol {
    // MARK: - Properties
    
    private lazy var dateFormatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss.SSS"
        return dateFormatter
    }()
    
    private var requestStartDates: [AnyHashable: Date] = [:]
    
    // MARK: - NetworkListenerProtocol
    
    func dataRequest(with id: AnyHashable, target: TargetType, didChangeState newState: DataRequestState) {
        var description = """
                          :::::::::::::::::::::::::::::::::::::::
                          🌎 REQUEST (\(newState.description) state) \(dateFormatter.string(from: Date()))
                          
                          """
        description += target.debugDescription
        
        switch newState {
        case .invalidTarget(let error):
            description += "\n\t🛑 Invalid request attempt. INVALID TARGET ERROR: \(error.localizedDescription)"
            
        case .willBeSent(let urlRequest):
            description += urlRequest.debugDescription
            requestStartDates[id] = Date()
            
        case .serverResponse(let request, let  response, let data):
            description += request.debugDescription
            let duration = requestStartDates[id].map { Date() - $0 }
            requestStartDates[id] = .none
            description += response?.debugDescription(duration, data: data) ?? "\n\t⚠️ URLResponse IS NIL\n"
            
        case .requestError(let request, let error):
            description += request.debugDescription
            description += "\n\t🛑 Server ERROR: \(error.localizedDescription)"
            
        case .failedDecoding(let error):
            description += "\n\t🛑 Successful response but obtain an error on domen model decoding stage. Error: \(error.localizedDescription)"
            
        case .decodedModel(let model):
            description += "\n\t✅ Successful final domen model decoding. Model: \(model)"
        }
        
        description += "\n:::::::::::::::::::::::::::::::::::::::\n"
        
        print(description)
    }
}

// MARK: - URLResponse Extension

private extension URLResponse {
    func debugDescription(
        _ requestDuration: TimeInterval?,
        data: Data?,
        validRequestCodeRange: ClosedRange<Int> = 200...399
    ) -> String {
        var statusCodeDescr = "⚠️ Unknown"
        var responseHeaders = "nil"
        var responseBody = "nil"
        
        if let code = (self as? HTTPURLResponse)?.statusCode {
            let codeEmoji = validRequestCodeRange.contains(code) ? "✅" : "⚠️"
            statusCodeDescr = "\(codeEmoji) \(code)"
        }
        
        if let headers = (self as? HTTPURLResponse)?.allHeaderFields {
            responseHeaders = "\n"
            responseHeaders += headers.prettyDescription.addBeforeEachNewLine(text: "\t\t\t")
        }
        
        if let data = data {
            do {
                responseBody = "\n"
                responseBody += try data.toJSON().prettyDescription.addBeforeEachNewLine(text: "\t\t\t")
            } catch {
                responseBody = "🛑 Data is obtained but the debug decoding attempt was failed. Error: \(error.localizedDescription)"
            }
        }
        
        let requestDuration = requestDuration.map { "\($0) sec" } ?? "Unknown"
        
        return """
               
               \tRESPONSE:
               \t\tStatus code: \(statusCodeDescr)
               \t\tExecuting duration: \(requestDuration)
               \t\tResponse headers: \(responseHeaders)
               \t\tResponse body: \(responseBody)
               """
    }
}

// MARK: - URLRequest Extension

private extension URLRequest {
    var debugDescription: String {
        var bodyDescription: String = " nil"
        if let body = self.httpBody {
            do {
                let json = try body.toJSON()
                bodyDescription = "\n" + json.prettyDescription.addBeforeEachNewLine(text: "\t\t\t")
            } catch {
                bodyDescription = "⚠️ Request contains httpBody but during decodeing attempt obtain the ERROR: \(error.localizedDescription)"
            }
        }
        
        return """
               
               \tURL REQUEST
               \t\tURL: \(self.url?.absoluteString ?? " nil")
               \t\tMethod: \(self.httpMethod ?? "nil")
               \t\tHeaders: \(self.allHTTPHeaderFields ?? [:])
               \t\tBody:\(bodyDescription)
               
               """
    }
}

// MARK: - TargetType Extensions

private extension TargetType {
    var debugDescription: String {
        let parametersDescription = (parameters?.prettyDescription).map { description -> String in
            let descriptionWithTabs = description.addBeforeEachNewLine(text: "\t\t\t")
            return "\n\(descriptionWithTabs)"
        }
        return  """
                
                \tTARGET MODEL
                \t\tURL: \(urlDebugDescription)
                \t\tMethod: \(method.rawValue)
                \t\tHeaders: \(headers ?? [:])
                \t\tParameters:\(parametersDescription ?? " nil")
                
                """
    }
    
    private var urlDebugDescription: String {
        do {
            let url = try asURL()
            return url.absoluteString
        } catch {
            return "🛑 Invalid url. ERROR:\nScheme: \(self.scheme)\nHost: \(self.host), Path: \(self.path)"
        }
    }
}

// MARK: - DataRequestState Extension

private extension DataRequestState {
    var description: String {
        switch self {
        case .invalidTarget:
            return "invalidTarget"
            
        case .willBeSent:
            return "willBeSent"
            
        case .serverResponse:
            return "serverResponse"
            
        case .requestError:
            return "requestError"
            
        case .failedDecoding:
            return "failedDecoding"
            
        case .decodedModel:
            return "decodedModel"
        }
    }
}

// MARK: Dictionary Extensions

private extension JSON {
    var prettyDescription: String {
        (self as [AnyHashable: Any]).prettyDescription
    }
}

private extension Dictionary where Key == AnyHashable, Value == Any {
    var prettyDescription: String {
        let decodedString = convertToCirilicString(json: self)
        guard
            let jsonData = try? JSONSerialization.data(withJSONObject: decodedString, options: .prettyPrinted),
            let prettyJson = String(data: jsonData, encoding: .utf8)
        else {
            return ""
        }
        return prettyJson
    }
    
    private func convertToCirilicString(json: [AnyHashable: Any]) -> [AnyHashable: Any] {
        var result: [AnyHashable: Any] = [:]
        json.forEach({ key, value in
            let anyValue: Any
            if let stringValue = value as? String {
                anyValue = stringValue.decodingUnicodeCharacters.unescaped
            } else if let stringArray = value as? [String] {
                anyValue = stringArray.map({ $0.decodingUnicodeCharacters.unescaped })
            } else if let jsonValue = value as? JSON {
                anyValue = convertToCirilicString(json: jsonValue)
            } else if let jsonArray = value as? [JSON] {
                anyValue = jsonArray.map { convertToCirilicString(json: $0) }
            } else {
                anyValue = value
            }

            result[key] = anyValue
        })
        return result
    }
}

// MARK: - Data Extension

private extension Data {
    enum JSONSerializationError: Error {
        case decodedDataIsNotJsonType
    }
    
    func toJSON() throws -> JSON {
        guard let json = try JSONSerialization.jsonObject(with: self) as? JSON else {
            throw JSONSerializationError.decodedDataIsNotJsonType
        }
        return json
    }
}

// MARK: - String Extensions

private extension String {
    var decodingUnicodeCharacters: String {
        let wI = NSMutableString(string: self)
        CFStringTransform(wI, UnsafeMutablePointer<CFRange>(nil), "Any-Hex/Java" as CFString, true)
        return wI as String
    }
    
    var unescaped: String {
        let entities = ["\0", "\t", "\n", "\r", "\"", "\'", "\\"]
        var current = self
        for entity in entities {
            let descriptionCharacters = entity.debugDescription.dropFirst().dropLast()
            let description = String(descriptionCharacters)
            current = current.replacingOccurrences(of: description, with: entity)
        }
        return current
    }
    
    func addBeforeEachNewLine(text: String) -> String {
        text + self.replacingOccurrences(of: "\n", with: "\n\(text)")
    }
}

// MARK: - Date Extra

private extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
