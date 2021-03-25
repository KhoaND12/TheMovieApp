//
//  NetworkingType.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 17/03/2021.
//

import Moya
import Resolver


// MARK: - NetworkingType
protocol NetworkingType {
    associatedtype T: TargetType
    var provider: ApiProvider<T> { get }
}

extension NetworkingType {
    
    static var plugins: [PluginType] {
        
        let formatter = NetworkLoggerPlugin.Configuration.Formatter(requestData: JSONResponse.formatter,
                                                                    responseData: JSONResponse.formatter)
        let config = NetworkLoggerPlugin.Configuration(formatter: formatter,
                                                       logOptions: .verbose)
        return [NetworkLoggerPlugin(configuration: config)]
    }
    
    static var endpointResolver: MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest()
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch {
                logError(error.localizedDescription)
            }
        }
    }
}

// MARK: - JSONResponse.formatter
struct JSONResponse {
    static func formatter(_ data: Data) -> String {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? "## Cannot map data to String ##"
        } catch {
            return String(data: data, encoding: .utf8) ?? "## Cannot map data to String ##"
        }
    }
}
