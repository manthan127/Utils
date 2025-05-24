//
//  File.swift
//  
//
//  Created by Home on 13/07/24.
//

import Foundation
/// A strongly-typed wrapper for raw `String` keys used with `UserDefaults`.
///
/// `UserDefaultsKeys` helps avoid hardcoding strings directly into your `UserDefaults` code,
/// improving type safety and reducing errors from mistyped key names.
///
/// You can extend `UserDefaultsKeys` with static properties representing each key,
/// making it easy and consistent to reuse keys throughout your application.
///
/// ### Usage:
///
/// Define your custom keys as static properties in an extension:
/// ```swift
/// extension UserDefaultsKeys {
///     static var settings: Self {
///         .init(rawValue: "settings")
///     }
///
///     static var username: Self {
///         .init(rawValue: "username")
///     }
/// }
/// ```
///
/// Use these keys to store or retrieve Codable values from `UserDefaults`:
/// ```swift
/// struct Settings: Codable {
///     var darkModeEnabled: Bool
///     var preferredLanguage: String
/// }
///
/// let settings = Settings(darkModeEnabled: true, preferredLanguage: "en")
///
/// // Save to UserDefaults
/// UserDefaults.standard[.settings] = settings
///
/// // Read from UserDefaults with error handling
/// let loadedSettings: Settings? = UserDefaults.standard[.settings, onError: { error in
///     print("Failed to decode Settings:", error)
/// }]
///
/// // Read from UserDefaults and throw on failure
/// do {
///     let settings: Settings? = try UserDefaults.standard[.settings]
/// } catch {
///     print("Decoding error: \(error)")
/// }
/// ```
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
    
    private func object<D: Decodable>(forType type: D.Type, forKey key: UserDefaultsKeys, onError: ((Error)->())?)-> D? {
        do {
            return try object(forType: D.self, forKey: key)
        } catch {
            onError?(error)
            return nil
        }
    }
    
    subscript<E: Codable>(key: UserDefaultsKeys, onError: ((Error)->())? = nil) -> E? {
        get {
            object(forType: E.self, forKey: key, onError: onError)
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
