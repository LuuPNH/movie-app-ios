//
//  File.swift
//  
//
//  Created by Luu Phan on 13/02/2023.
//

import Foundation

@propertyWrapper
public struct AppStorage<Value> {
    let key: String
    var defaultValue: Value?
    var storage: UserDefaults = .standard

    public init(key: String, defaultValue: Value? = nil, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }

    public var wrappedValue: Value? {
        get {
            let value = storage.value(forKey: key) as? Value
            return value ?? defaultValue
        }
        set {
            storage.setValue(newValue, forKey: key)
        }
    }
}

@propertyWrapper
public struct AppStorageObject<T: Codable> {
    private let key: String
    var storage: UserDefaults = .standard

    public init(key: String, storage: UserDefaults = .standard) {
        self.key = key
        self.storage = storage
    }

    public var wrappedValue: T? {
        get {
            guard let data = storage.object(forKey: key) as? Data else { return nil }
            
            return data()
        }
        set {
            guard let newValue = newValue else {
                storage.set(nil, forKey: key)
                return
            }
            storage.set(newValue.data, forKey: key)
        }
    }
}


public extension Encodable {
    var data: Data {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            print("[Encodable.data] error: \(error) ")
            return .init()
        }
    }
}

