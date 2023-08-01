//
//  SearchMovieUseCase.swift
//  
//
//  Created by Hải Lưu on 06/07/2023.
//

import Foundation
import DependencyKit

public class SearchMovieUseCase: AsyncUseCase {
    
    @Injected(Container.theMovieDBService) var theMovieDBService
    
    public func callAsFunction(_ input: (keyword: String, page: Int)) async throws -> [Movie] {
        let data = try await theMovieDBService.getListSearchMovie(keyword: input.keyword, page: input.page)
        return data
    }
    
    public typealias Input = (keyword: String, page: Int)
    
    public typealias Output = [Movie]
    
    
}
