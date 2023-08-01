//
//  TheMovieDBSeverviceImpl.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import Foundation
import Domain
import DependencyKit
import Moya



public class TheMovieDBSeverviceImpl: TheMovieDBService {
    public func getListSearchMovie(keyword: String, page: Int = 1) async throws -> [Domain.Movie] {
        do {
            let data: ResultDataMovieMapper = try await network.request(targetType: TheMovieDBApiTarget.getListSearchMovie(keyword: keyword, page: page))
            return data.toDomain().data
        } catch let error {
            throw error
        }
    }
    
    public func getVideoMovie(id: Int) async throws -> VideoMovie {
        let data: ResultDataMapper<[VideoMovieMapper]> = try await network.request(targetType: TheMovieDBApiTarget.getVideoMovie(id: id))
        if let result = data.result?.first {
            return try result.toDomain()
        }
        throw ErrorModelMapper(message: "No Video", filePath: #filePath)
    }
    
    public func getDetailMovie(id: Int) async throws -> Domain.Movie {
        do {
            let data: MovieMapper = try await network.request(targetType: TheMovieDBApiTarget.getDataCustom(path: "movie/\(id)"))
            return data.toDomain()
        } catch let error {
            throw error
        }
    }
    
    public func getTrendingMovies() async throws -> [Domain.Movie] {
        do {
            let data: ResultDataMovieMapper = try await network.request(targetType: TheMovieDBApiTarget.getListDataCustom(path: "trending/movie/day"))
            return data.toDomain().data
        } catch let error {
            throw error
        }
    }
    
    public func getListMovie(page: Int, type: CategoriesMovie) async throws -> [Movie] {
        do {
            let data: ResultDataMovieMapper = try await network.request(targetType: TheMovieDBApiTarget.getListMovie(page: page, type: type))
            let movies: [Movie] = data.toDomain().data
            return movies
        } catch let error {
            throw error
        }
    }
    
    @Injected(Container.network) var network
}

enum TheMovieDBApiTarget {
    case getListMovie(page: Int, type: CategoriesMovie)
    case getListDataCustom(page: Int = 1, path: String)
    case getDataCustom(path: String)
    case getVideoMovie(id: Int)
    case getListSearchMovie(keyword: String, page: Int = 1)
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
        case let .getListDataCustom(_, path):
            return path
        case .getDataCustom(path: let path):
            return path
        case .getVideoMovie(id: let id):
            return "movie/\(id)/videos"
        case .getListSearchMovie:
            return "search/movie"
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
        case let .getListDataCustom(page, _):
            return .requestParameters(
                parameters:
                    [
                        "api_key" : env.apiKey,
                        "language": "en-US",
                        "page": page
                    ],
                encoding: URLEncoding.default)
        case .getDataCustom:
            return .requestParameters(
                parameters:
                    [
                        "api_key" : env.apiKey,
                    ],
                encoding: URLEncoding.default)
        case .getVideoMovie:
            return .requestParameters(
                parameters:
                    [
                        "api_key" : env.apiKey,
                    ],
                encoding: URLEncoding.default)
        case .getListSearchMovie(keyword: let keyword, page: let page):
            return .requestParameters(
                parameters:
                    [
                        "api_key" : env.apiKey,
                        "language": "en-US",
                        "page": page,
                        "query": keyword
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

