//
//  CarouselUseCase.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import Foundation
import DependencyKit

public class CarouselUseCase: AsyncUseCase {
    
    @Injected(Container.theMovieDBService) var theMovieDBService
    
    public func callAsFunction(_ input: Void) async throws -> [Movie] {
        let data = try await theMovieDBService.getListMovie(page: 1, type: .nowPlaying)
        return data
    }
    
    public typealias Input = Void
    
    public typealias Output = [Movie]
    
}
