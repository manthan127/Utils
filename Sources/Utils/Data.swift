//
//  Dta.swift
//  Utils
//
//  Created by Home on 17/04/25.
//

import Foundation

extension Data {
    func jsonDecoded<D: Decodable>(_ type: D.Type, decoder: JSONDecoder = JSONDecoder()) throws -> D {
        try decoder.decode(type, from: self)
    }
}

extension Encodable {
    func jsonEncoded(encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        try encoder.encode(self)
    }
}

extension String {
    func JSONData() throws -> Any? {
        if let data = self.data(using: .utf8) {
            return try JSONSerialization.jsonObject(with: data)
        }
        return nil
    }
    
    func JSONData<T>(ofType type: T.Type) throws -> T? {
        if let data = self.data(using: .utf8) {
            return try JSONSerialization.jsonObject(with: data) as? T
        }
        return nil
    }
    
    func decode<D: Decodable>(to type: D.Type) throws -> D? {
        try self.data(using: .utf8)?.jsonDecoded(D.self)
    }
}
