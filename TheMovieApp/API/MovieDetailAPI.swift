//
//  MovieDetailAPI.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import Moya

public enum MovieDetailAPI {
    case detail(id: Int)
    case seriesCasts(id: Int)
    case videos(id: Int)
    case reviews(id: Int)
    case recommends(id: Int)
}

extension MovieDetailAPI: TargetType {
    public var baseURL: URL { return Environment.apiUrl }
    public var path: String {
        switch self {
        case .detail(let id):
            return "/movie/\(id)"
        case .seriesCasts(let id):
            return "/movie/\(id)/credits"
        case .videos(let id):
            return "/movie/\(id)/videos"
        case .reviews(let id):
            return "/movie/\(id)/reviews"
        case .recommends(let id):
            return "/movie/\(id)/recommendations"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        return .requestParameters(parameters: ["api_key": Environment.apiKey],
                                  encoding: URLEncoding.default)
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
