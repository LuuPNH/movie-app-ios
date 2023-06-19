//
//  VideoMovie.swift
//  
//
//  Created by Hải Lưu on 12/06/2023.
//

import Foundation
public class VideoMovie {
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt: String
    let id: String
    public let key: String
    
    public init(site: String, size: Int, type: String, official: Bool, publishedAt: String, id: String, key: String) {
        self.site = site
        self.size = size
        self.type = type
        self.official = official
        self.publishedAt = publishedAt
        self.id = id
        self.key = key
    }
}
