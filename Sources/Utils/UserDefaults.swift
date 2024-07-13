//
//  File.swift
//  
//
//  Created by Home on 13/07/24.
//

import Foundation

extension UserDefaults {
    private func setValue<E: Encodable>(_ object: E?, forKey key: String, _ onError: ((Error)->())? = nil) {
        if object == nil {
            return removeObject(forKey: key)
        }
        
        do {
            let data = try JSONEncoder().encode(object)
            self.set(data, forKey: key)
        } catch {
            onError?(error)
        }
    }

    private func object<D: Decodable>(forType type: D.Type, forKey key: String, _ onError: ((Error)->())? = nil)-> D? {
        guard let data = self.data(forKey: key) else {return nil}
        do {
            return try JSONDecoder().decode(D.self, from: data)
        } catch {
            onError?(error)
            return nil
        }
    }
    
    public subscript<E: Codable>(key: String, onError: ((Error)->())? = nil) -> E? {
        get {
            object(forType: E.self, forKey: key, onError)
        } set {
            setValue(newValue, forKey: key, onError)
        }
    }
}

