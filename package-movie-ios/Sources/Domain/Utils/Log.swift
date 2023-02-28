//
//  dlog.swift
//  
//
//  Created by Luu Phan on 16/02/2023.
//

import Foundation

public func dLog(_ message: String) {
    #if DEBUG
    print("DEBUG: \(message)");
    #endif
}
