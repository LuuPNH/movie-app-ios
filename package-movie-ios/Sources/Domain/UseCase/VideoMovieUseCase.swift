//
//  File.swift
//  
//
//  Created by Hải Lưu on 12/06/2023.
//

import Foundation
import DependencyKit

public class VideoMovieUseCase: AsyncUseCase {
    
    @Injected(Container.theMovieDBService) var theMovieDBService
    
    public func callAsFunction(_ input: Int) async throws -> VideoMovie {
        let data = try await theMovieDBService.getVideoMovie(id: input)
        return data
    }
    
    public typealias Input = Int
    
    public typealias Output = VideoMovie
    
    
}
