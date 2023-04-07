//
//  Movie.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import Foundation

public struct Movie: Hashable, Identifiable {
    public let adult: Bool
    public let backdropPath: String
    public let genreIDS: [Int]
    public let id: Int
    public let originalLanguage: String
    public let originalTitle, overview: String
    public let popularity: Double
    public let posterPath, releaseDate, title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
    
    public init(adult: Bool, backdropPath: String, id: Int, genreIDS: [Int], originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String, releaseDate: String, title: String, video: Bool, voteAverage: Double,voteCount: Int) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = (Double(voteAverage) * 50) / 100
        self.voteCount = voteCount
    }
}
