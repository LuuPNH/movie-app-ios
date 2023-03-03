//
//  CarouselSeverviceImpl.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import Foundation
import Domain
import DependencyKit
import Moya



public class CarouselSeverviceImpl: CarouselService {
    
    @Injected(Container.network) var network
    
    public func getListCarousel(page: Int) async throws -> [Domain.Movie] {
        
        let data: ResultDataMapper = try await network.request(targetType: CarouselApiTarget.getListNowPlaying)
        
        
        
        return data.toDomain().data
    }
}

enum CarouselApiTarget {
    case getListNowPlaying
}

extension CarouselApiTarget: TargetType, EnvironmentProvider {
    var baseURL: URL {
        env.baseUrl
    }
    
    var path: String {
        "movie/now_playing"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestParameters(
            parameters:
                ["api_key" : env.apiKey,
                 "language": "en-US",
                 "page": 1],
            encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var validationType: ValidationType {
        .successCodes
    }
}

