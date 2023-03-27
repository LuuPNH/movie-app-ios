//
//  CarouselService.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import Foundation

public protocol TheMovieDBService {
    
    func getListMovie(page: Int, type: CategoriesMovie) async throws -> [Movie]

}

