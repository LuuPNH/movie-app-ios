//
//  File.swift
//  
//
//  Created by Hải Lưu on 12/06/2023.
//

import Foundation
public struct ErrorModelMapper: Error {
    let message: String
    
    public init(message: String, filePath: String = #filePath) {
        Logger.e(message, fileName: filePath)
        self.message = message
    }
}
