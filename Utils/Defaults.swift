//
//  Defaults.swift
//  Utils
//
//  Created by Home on 08/03/25.
//

import Foundation

// TODO: different set and get function for different types types (Bool, URL?, String, Int, Float, Double, Any??)
public class Defaults {
    static public var standard = Defaults()
    
    private let userDefaults: UserDefaults
    
    public init() {
        self.userDefaults = .standard
    }
    
    public init?(suiteName: String?) {
        guard let userDefaults = UserDefaults(suiteName: suiteName) else {return nil}
        self.userDefaults = userDefaults
    }
    
    public init(withSuite suite: UserDefaults) {
        self.userDefaults = suite
    }
    
    public func set<E: Encodable>(_ object: E?, forKey key: String, _ onError: ((Error)->())? = nil) {
        if object == nil {
            return removeObject(forKey: key)
        }
        do {
            let data = try JSONEncoder().encode(object)
            userDefaults.set(data, forKey: key)
        } catch {
            onError?(error)
        }
    }
    
    public func removeObject(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    public func object<D: Decodable>(forType type: D.Type, forKey key: String, _ onError: ((Error)->())? = nil)-> D? {
        guard let data = userDefaults.data(forKey: key) else {return nil}
        do {
            return try JSONDecoder().decode(D.self, from: data)
        } catch {
            onError?(error)
            return nil
        }
    }
    
    public func object<D: Decodable>(forType type: D.Type, forKey key: String) throws -> D? {
        try userDefaults.data(forKey: key).map({
            try JSONDecoder().decode(D.self, from: $0)
        })
    }
    
    public subscript<E: Codable>(key: String, onError: ((Error)->())? = nil) -> E? {
        get {
            object(forType: E.self, forKey: key, onError)
        } set {
            set(newValue, forKey: key, onError)
        }
    }
    
    public subscript<E: Codable>(key: String) -> E? {
        get throws {
            try object(forType: E.self, forKey: key)
        }
    }
}
