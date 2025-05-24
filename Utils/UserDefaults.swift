//
//  File.swift
//  
//
//  Created by Home on 13/07/24.
//

import Foundation

struct UserDefaultsKeys: RawRepresentable {
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    var rawValue: String

}

extension UserDefaults {
    private func setValue<E: Encodable>(_ object: E?, forKey key: UserDefaultsKeys, _ onError: ((Error)->())?) {
        if object == nil {
            return removeObject(forKey: key.rawValue)
        }
        do {
            let data = try JSONEncoder().encode(object)
            self.set(data, forKey: key.rawValue)
        } catch {
            onError?(error)
        }
    }

    private func object<D: Decodable>(forType type: D.Type, forKey key: UserDefaultsKeys) throws -> D? {
        guard let data = self.data(forKey: key.rawValue) else {return nil}
        
        return try JSONDecoder().decode(D.self, from: data)
    }
    
    private func object<D: Decodable>(forType type: D.Type, forKey key: UserDefaultsKeys, _ onError: ((Error)->())?)-> D? {
        do {
            return try object(forType: D.self, forKey: key)
        } catch {
            onError?(error)
            return nil
        }
    }
    
    subscript<E: Codable>(key: UserDefaultsKeys, onError: ((Error)->())? = nil) -> E? {
        get {
            object(forType: E.self, forKey: key, onError)
        } set {
            setValue(newValue, forKey: key, onError)
        }
    }
    
    subscript<E: Codable>(key: UserDefaultsKeys) -> E? {
        get throws {
            try object(forType: E.self, forKey: key)
        }
    }
}
