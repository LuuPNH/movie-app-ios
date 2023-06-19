//
//  CarouselService.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import Foundation

public protocol TheMovieDBService {
    
    func getListMovie(page: Int, type: CategoriesMovie) async throws -> [Movie]
    
    func getTrendingMovies() async throws -> [Movie]
    
    func getDetailMovie(id: Int) async throws -> Movie
    
    func getVideoMovie(id: Int) async throws -> VideoMovie
        
}

