//
//  VideoMovieMapper.swift
//  
//
//  Created by Hải Lưu on 12/06/2023.
//

import Foundation
import Domain

public struct VideoMovieMapper: Codable {
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id, key: String?
    
    enum CodingKeys: String, CodingKey {
        case site
        case size
        case type
        case official
        case publishedAt = "published_at"
        case id
        case key
    }
    
    func toDomain() throws -> VideoMovie  {
        
        if id == nil {
            throw ErrorModelMapper(message: "Video have ID empty")
        }
        return VideoMovie(
            site: site ?? "",
            size: size ?? 0,
            type: type ?? "",
            official: official ?? false,
            publishedAt: publishedAt ?? "",
            id: id!,
            key: key ?? ""
        )
    }
}
