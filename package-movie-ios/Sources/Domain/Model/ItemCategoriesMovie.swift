//
//  ItemCategoriesMovie.swift
//  
//
//  Created by Luu Phan on 27/03/2023.
//

import Foundation
public struct ItemCategoriesMovie {
    public var type: CategoriesMovie
    
    public var movies: [Movie]
    
    public var isLoading: Bool
    
    public init(type: CategoriesMovie, movies: [Movie], isLoading: Bool) {
        self.type = type
        self.movies = movies
        self.isLoading = isLoading
    }
    
    public func copyWith(type: CategoriesMovie? = nil, movies: [Movie]? = nil, isLoading: Bool?) -> ItemCategoriesMovie {
        ItemCategoriesMovie(type: type ?? self.type, movies: movies ?? self.movies, isLoading: isLoading ?? self.isLoading)
    }
}
