//
//  DetailUseCase.swift
//  
//
//  Created by Luu Phan on 08/05/2023.
//

import Foundation
import DependencyKit

public class DetailUseCase: AsyncUseCase {
    
    @Injected(Container.theMovieDBService) var theMovieDBService
    
    public func callAsFunction(_ input: Int) async throws -> Movie {
        let data = try await theMovieDBService.getDetailMovie(id: input)
        return data
    }
    
    public typealias Input = Int
    
    public typealias Output = Movie
    
    
}
