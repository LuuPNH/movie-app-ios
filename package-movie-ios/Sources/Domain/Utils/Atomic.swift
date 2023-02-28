//
//  Atomic.swift
//  
//
//  Created by Luu Phan on 16/02/2023.
//

import Foundation

@propertyWrapper
public class Atomic<Value> {
    private let queue = DispatchQueue(label: "com.app.atomic")
    private var value: Value
    
    public init(wrappedValue: Value) {
        self.value = wrappedValue
    }
    
    public var wrappedValue: Value {
        get {
            queue.sync { value }
        }
        set {
            queue.sync {
                value = newValue
            }
        }
    }
    
    public var projectValue: Atomic<Value> {
        return self
    }
    
    public func mutate(_ mutation: (inout Value) -> Void) {
        return queue.sync {
            mutation(&value)
        }
    }
}
