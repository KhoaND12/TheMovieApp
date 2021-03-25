//
//  ConfigKeys.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import Foundation

enum ConfigurationKey {
    enum Keys {
        enum Domain {
            static let domain = "DOMAIN"
            static let apiEndpoint = "API_ENDPOINT"
            
            static let imageDomain = "IMAGE_DOMAIN"
            static let videoDomain = "VIDEO_DOMAIN"
        }
        
        enum api {
            static let token = "API_TOKEN"
        }
    }

    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

// MARK: - Domain
extension Environment {
    static var onlyDomainURL: URL { return URL(string: try! (ConfigurationKey.value(for: ConfigurationKey.Keys.Domain.domain)))! }
    static var apiUrl: URL { return URL(string: try! (ConfigurationKey.value(for: ConfigurationKey.Keys.Domain.domain)
                                                        +  ConfigurationKey.value(for: ConfigurationKey.Keys.Domain.apiEndpoint)))! }
    
    static var imageDomainURL: URL { return URL(string: try! (ConfigurationKey.value(for: ConfigurationKey.Keys.Domain.imageDomain)))! }
    
    static var videoDomainURL: URL { return URL(string: try! (ConfigurationKey.value(for: ConfigurationKey.Keys.Domain.videoDomain)))! }
}

// MARK: - Key
extension Environment {
    static var apiKey: String { return try! ConfigurationKey.value(for: ConfigurationKey.Keys.api.token) }
}

