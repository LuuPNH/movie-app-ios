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



public class TheMovieDBSeverviceImpl: TheMovieDBService {
    @Injected(Container.network) var network
    
    
    public func getTrendingMovies() async throws -> [Domain.Movie] {
        
        let data: ResultDataMapper = try await network.request(targetType: TheMovieDBApiTarget.getDataCustom(path: "trending/movie/day"))
        
        return data.toDomain().data
    }
    
    public func getListMovie(page: Int, type: CategoriesMovie) async throws -> [Movie] {
        do {
            let data: ResultDataMapper = try await network.request(targetType: TheMovieDBApiTarget.getListMovie(page: page, type: type))
            let movies: [Movie] = data.toDomain().data
            return movies
        } catch let error {
            throw error
        }
    }
}

enum TheMovieDBApiTarget {
    case getListMovie(page: Int, type: CategoriesMovie)
    case getDataCustom(page: Int = 1, path: String)
}

extension TheMovieDBApiTarget: TargetType, EnvironmentProvider {
    
    var baseURL: URL {
        env.baseUrl
    }
    
    var path: String {
        
        switch self {
        case let .getListMovie(_, type):
            switch type {
            case .nowPlaying:
                return "movie/now_playing"
            case .topRate:
                return "movie/top_rated"
            case .upComing:
                return "movie/upcoming"
            case .upLatest:
                return "movie/latest"
            case .popular:
                return "movie/popular"
            }
        case let .getDataCustom(_, path):
            return path
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch ( self ) {
        case let .getListMovie(page, _):
            return .requestParameters(
                parameters:
                    [
                        "api_key" : env.apiKey,
                        "language": "en-US",
                        "page": page
                    ],
                encoding: URLEncoding.default)
        case let .getDataCustom(page, _):
            return .requestParameters(
                parameters:
                    [
                        "api_key" : env.apiKey,
                        "language": "en-US",
                        "page": page
                    ],
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var validationType: ValidationType {
        .successCodes
    }
}

