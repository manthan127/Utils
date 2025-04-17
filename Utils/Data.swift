//
//  Dta.swift
//  Utils
//
//  Created by Home on 17/04/25.
//

import Foundation

extension Data {
    func decode<D: Decodable>(_ type: D.Type, decoder: JSONDecoder = JSONDecoder()) throws -> D {
        try decoder.decode(type, from: self)
    }
}

extension Encodable {
    func encode(encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        try encoder.encode(self)
    }
}

extension String {
    func JSONData() throws -> [String: Any]? {
        try self.data(using: .utf8).flatMap {
            try JSONSerialization.jsonObject(with: $0) as? [String: Any]
        }
    }
    
    func decode<D: Decodable>(to type: D.Type) throws -> D? {
        try self.data(using: .utf8)?.decode(D.self)
    }
}
