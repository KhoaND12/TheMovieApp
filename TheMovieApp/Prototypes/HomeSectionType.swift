//
//  HomeSectionType.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//
import DifferenceKit

enum HomeSectionType {
    
    case trending
    case category
    case popular(offset: Int)
    case topRated(offset: Int)
    case upComing(offset: Int)
    case undefined
    
    var pageOffset: Int {
        switch self {
        case .popular(let offset), .topRated(let offset), .upComing(let offset):
            return offset
        default:
            return 0
        }
    }
    
    var name: String {
        switch self {
        case .trending:
            return "TREDNING"
        case .category:
            return "GENRE"
        case .popular:
            return "POPULAR"
        case .topRated:
            return "TOP RATED"
        case .upComing:
            return "UPCOMING"
        default:
            return ""
        }
    }
}

extension HomeSectionType: Equatable {
    static func ==(lhs: HomeSectionType, rhs: HomeSectionType) -> Bool {
        switch (lhs, rhs) {
        case (.trending, .trending), (.category, .category),
             (.popular, .popular), (.topRated, .topRated),
             (.upComing, .upComing):
            return true
        default:
            return false
        }
    }
}

extension HomeSectionType: Differentiable {
    
    var differenceIdentifier: Int {
        switch self {
        case .trending: return 1
        case .category: return 2
        case .popular: return 3
        case .topRated: return 4
        case .upComing: return 5
        default: return 0
        }
    }
    func isContentEqual(to source: HomeSectionType) -> Bool {
        self == source
    }
}
