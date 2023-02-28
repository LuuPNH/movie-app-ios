//
//  Task++.swift
//  
//
//  Created by Luu Phan on 20/02/2023.
//

import Foundation
import Combine

public extension Task {
    func asCancellable() -> AnyCancellable {
        return .init {
            cancel()
        }
    }
    
    func store(in set: inout Set<AnyCancellable>) {
        set.insert(asCancellable())
    }
}
