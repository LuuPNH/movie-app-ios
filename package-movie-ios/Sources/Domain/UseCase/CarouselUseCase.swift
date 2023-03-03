//
//  CarouselUseCase.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import Foundation

public class CarouselUseCase: AsyncUseCase {
    public func callAsFunction(_ input: Void) async throws -> [Movie] {
        []
    }
    
    public typealias Input = Void
    
    public typealias Output = [Movie]
    
    
}
