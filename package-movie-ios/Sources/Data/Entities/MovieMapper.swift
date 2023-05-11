//
//  MovieMapper.swift
//  
//
//  Created by Luu Phan on 02/03/2023.
//

import Foundation

import Domain

public struct MovieMapper: Codable {
    public let adult: Bool?
    public let backdropPath: String?
    public let genreIDS: [Int]?
    public let id: Int
    public let originalLanguage: String?
    public let originalTitle, overview: String?
    public let popularity: Double?
    public let posterPath, releaseDate, title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?
    public let mediaType: String?
    public let runtime: Int?
    
    
    public func toDomain() -> Movie {
        .init(
            adult: adult ?? false,
            backdropPath: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")",
            id: id,
            genreIDS: genreIDS ?? [],
            originalLanguage: originalLanguage ?? "--",
            originalTitle: originalTitle ?? "--",
            overview: overview ?? "--",
            popularity: popularity ?? 0.0,
            posterPath: posterPath ?? "--",
            releaseDate: releaseDate ?? "--",
            title: title ?? "--",
            video: video ?? false,
            voteAverage: voteAverage ?? 0.0,
            voteCount: voteCount ?? 0,
            mediaType: mediaType ?? "--",
            runtime: runtime ?? 0
        )
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case mediaType = "media_type"
        case runtime
    }
}
