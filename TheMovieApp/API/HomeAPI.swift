//
//  HomeAPI.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import Moya

public enum HomeAPI {
    case trending
    case category
    case popular(offset: Int)
    case topRated(offset: Int)
    case upcoming(offset: Int)
}

extension HomeAPI: TargetType {
    public var baseURL: URL { return Environment.apiUrl }
    public var path: String {
        switch self {
        case .trending:
            return "/trending/movie/day"
        case .category:
            return "/genre/movie/list"
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .upcoming:
            return "/movie/upcoming"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        switch self {
        case .trending, .category:
            return .requestParameters(parameters: ["api_key": Environment.apiKey],
                                      encoding: URLEncoding.default)
        case .popular(let offset), .topRated(let offset), .upcoming(let offset):
            return .requestParameters(parameters: ["api_key": Environment.apiKey,
                                                   "page" : offset],
                                      encoding: URLEncoding.default)
        }
    }
    
    public var validationType: ValidationType {
        return .none
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String : String]? {
        return [:]
    }
}
