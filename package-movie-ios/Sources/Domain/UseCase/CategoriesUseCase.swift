//
//  CategoriesUseCase.swift
//  
//
//  Created by Luu Phan on 28/04/2023.
//

import Foundation
import DependencyKit

public class CategoriesUseCase: AsyncUseCase {
    
    @Injected(Container.theMovieDBService) var theMovieDBService
    
    public func callAsFunction(_ input: (page: Int, type: CategoriesMovie)) async throws -> [Movie] {
        let data = try await theMovieDBService.getListMovie(page: input.page, type: input.type)
        return data
    }
    
    public typealias Input = (page: Int, type: CategoriesMovie)
    
    public typealias Output = [Movie]
    
}
