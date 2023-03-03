//
//  ResultData.swift
//  
//
//  Created by Luu Phan on 02/03/2023.
//

import Foundation

public struct ResultData {
    
    public init(data: [Movie], page: Int) {
        self.data = data
        self.page = page
    }
    
    public let data: [Movie]
    let page: Int
}

