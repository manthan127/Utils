//
//  Defaults.swift
//  Utils
//
//  Created by Home on 08/03/25.
//

import Foundation

// TODO: add Discussion in docs
// TODO: different set and get function for different types types (Bool, URL?, String, Int, Float, Double, Any??)
/// An interface to the user’s defaults database, where you store key-value pairs persistently across launches of your app.
public class Defaults {
    /// Returns the shared defaults object.
    static public var standard = Defaults()

    private let userDefaults: UserDefaults

    /// An object to encode instances of a data type as JSON objects.
    public var encoder = JSONEncoder()
    /// An object to decode instances of a data type from JSON objects.
    public var decoder = JSONDecoder()

    /// Creates a Defaults object
    public init() {
        self.userDefaults = .standard
    }

    /// Creates a user Defaults object initialized with the defaults for the specified database name.
    /// - Parameters:
    ///     - suiteName:The domain identifier of the search list.
    public init?(suiteName: String?) {
        guard let userDefaults = UserDefaults(suiteName: suiteName) else {return nil}
        self.userDefaults = userDefaults
    }

    /// Creates a user Defaults object initialized with the given UserDefaults.
    /// - Parameters:
    ///     - suite:An object of UserDefaults to store data in.
    public init(withSuite suite: UserDefaults) {
        self.userDefaults = suite
    }

    /// Sets the value of the specified key.
    /// - Parameters:
    ///     - object:The object to store in the defaults database.
    ///     - key:The key with which to associate the value.
    ///     - onError:Completion holder called if there is some issue while encoding given object
    public func set<E: Encodable>(_ object: E?, forKey key: String, _ onError: ((Error)->())? = nil) {
        if object == nil {
            return removeObject(forKey: key)
        }
        do {
            let data = try encoder.encode(object)
            userDefaults.set(data, forKey: key)
        } catch {
            onError?(error)
        }
    }

    /// Removes the value of the specified default key.
    /// - Parameters:
    ///     - key:The key whose value you want to remove.
    public func removeObject(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }

    /// Returns a value of the type you specify, associated with the specified key.
    /// - Parameters:
    ///     - type:The type of the value to decode from the given key.
    ///     - key:A key in the current user‘s defaults database.
    ///     - onError:Completion holder called if there is some issue while decoding object stored at the key
    /// - Returns: A value of the specified type object associated with the specified key, or nil if the key does not exist, its value is not a data object, or object stored in key does not match the provided type
    public func object<D: Decodable>(forType type: D.Type, forKey key: String, _ onError: ((Error)->())? = nil)-> D? {
        guard let data = userDefaults.data(forKey: key) else {return nil}
        do {
            return try decoder.decode(D.self, from: data)
        } catch {
            onError?(error)
            return nil
        }
    }

    /// Returns a value of the type you specify, associated with the specified key. and Sets the value of the specified key.
    /// - Parameters:
    ///     - key:A key in the current user‘s defaults database.
    ///     - onError:Completion holder called if there is some issue while decoding object stored at the key
    public subscript<E: Codable>(key: String, onError: ((Error)->())? = nil) -> E? {
        get {
            object(forType: E.self, forKey: key, onError)
        } set {
            set(newValue, forKey: key, onError)
        }
    }
}

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {
    public var defaults: Defaults {
        get {
            Defaults.standard
        }
    }
}
