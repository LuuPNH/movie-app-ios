//
//  ResultDataMapper.swift
//  
//
//  Created by Hải Lưu on 13/06/2023.
//

import Foundation
struct ResultDataMapper<T: Codable>: Codable {
    let result: T?
    
    init(result: T?) {
        self.result = result
    }
    
    enum ResultDataMapper: String, CodingKey {
        case result = "results"
    }
}
