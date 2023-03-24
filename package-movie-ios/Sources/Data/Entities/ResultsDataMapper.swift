//
//  ResultDataMapper.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import Foundation
import Domain

struct ResultDataMapper: Codable {
    let data: [MovieMapper]
    let page: Int
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case data = "results"
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    func toDomain() -> ResultData {
        .init(data: data.map({ $0.toDomain() }), page: page)
    }
}
