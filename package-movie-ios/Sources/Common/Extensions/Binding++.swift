//
//  Binding++.swift
//  
//
//  Created by Luu Phan on 09/05/2023.
//

import SwiftUI

public extension Binding {
    func objectIdentifiable<T>() -> Binding<ObjectIdentifiable?> where Value == T? {
        .init(
            get: {
                wrappedValue.map { value in
                    ObjectIdentifiable(value)
                }
            },
            set: { newValue in
                if newValue == nil {
                    wrappedValue = nil
                }
            }
        )
    }

    func asBool<T>() -> Binding<Bool> where Value == T? {
        .init(
            get: { wrappedValue != nil },
            set: { value in
                if !value {
                    wrappedValue = nil
                }
            }
        )
    }
}

public struct ObjectIdentifiable: Identifiable {
    public var id: ObjectIdentifier

    public init(_ object: Any) {
        self.id = ObjectIdentifier(object as AnyObject)
    }
}

