//
//  MovieHomeSectionModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import DifferenceKit

enum HomeSectionModel: Differentiable {
    
    case trending(title: String, items: [TrendingDataType], size: HomeSectionSize)
    case category(title: String, items: [GenreDataType], size: HomeSectionSize)
    case popular(title: String, items: [MovieDataType], size: HomeSectionSize)
    case topRated(title: String, items: [MovieDataType], size: HomeSectionSize)
    case upComing(title: String, items: [MovieDataType], size: HomeSectionSize)
    
    var differenceIdentifier: Int {
        switch self {
        case .trending(let title, items: _, size: _): return title.hashValue
        case .category(let title, items: _, size: _): return title.hashValue
        case .popular(let title, items: _, size: _): return title.hashValue
        case .topRated(let title, items: _, size: _): return title.hashValue
        case .upComing(let title, items: _, size: _): return title.hashValue
        }
    }
    
    func isContentEqual(to source: HomeSectionModel) -> Bool {
        return false
    }
    
    var sectionSize: HomeSectionSize {
        switch self {
        case .trending(title: _, items: _, size: let size): return size
        case .category(title: _, items: _, size: let size): return size
        case .popular(title: _, items: _, size: let size): return size
        case .topRated(title: _, items: _, size: let size): return size
        case .upComing(title: _, items: _, size: let size): return size
        }
    }
    
    var popularItem: [MovieDataType] {
        switch self {
        case .popular(_, let items, _): return items
        default: return []
        }
    }
    
    var topRatedItem: [MovieDataType] {
        switch self {
        case .topRated(_, let items, _): return items
        default: return []
        }
    }
    
    var upComingItem: [MovieDataType] {
        switch self {
        case .upComing(_, let items, _): return items
        default: return []
        }
    }
    
}

