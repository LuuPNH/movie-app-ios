//
//  CarouselService.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import Foundation

public protocol CarouselService {
    
    func getListCarousel(page: Int) async throws -> [Movie]

}

