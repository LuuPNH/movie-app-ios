//
//  File.swift
//  
//
//  Created by Luu Phan on 13/02/2023.
//

import Foundation
import Domain

class KeyValueStore: KeyValue {
    
    func clear() {
        onboarding = nil
    }
    
    static let shared = KeyValueStore()
    
    @AppStorageObject(key: "onboarding")
    var onboarding: Domain.ShowOnboarding?
}
