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
    
    public func set<E: Encodable>(_ object: E?, forKey key: String) throws {
        if object == nil {
            return removeObject(forKey: key)
        }
        let data = try object.encode()
        userDefaults.set(data, forKey: key)
    }
    
    public func removeObject(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    public func object<D: Decodable>(forType type: D.Type, forKey key: String) throws -> D? {
        try userDefaults.data(forKey: key).map({
            try $0.decode(D.self)
        })
    }
    
    public subscript<E: Codable>(key: String) -> E? {
        get {
            try? object(forType: E.self, forKey: key)
        } set {
            try? set(newValue, forKey: key)
        }
    }
    
    public subscript<D: Decodable>(key: String) -> D? {
        get throws {
            try object(forType: D.self, forKey: key)
        }
    }
}
