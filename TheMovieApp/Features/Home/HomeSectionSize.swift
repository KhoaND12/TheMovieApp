//
//  MovieHomeSectionSize.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import UIKit

struct SectionSize {
    var section: CGSize
    var cell: CGSize
}

enum SectionType {
    case `default`
    case trending
    case category
    case popular
    case topRated
    case upComing
    
    var size: [SectionSize] {
        switch self {
        case .default: return []
        case .trending:
            return [SectionSize(section: CGSize(width: Constants.ScreenSize.Width, height: 210),
                                 cell: CGSize(width: 300, height: 160))]
        case .category:
            return [SectionSize(section: CGSize(width: Constants.ScreenSize.Width, height: 140),
                                cell: CGSize(width: 140, height: 76))]
        case .popular, .topRated, .upComing:
            return [SectionSize(section: CGSize(width: Constants.ScreenSize.Width, height: 320),
                                cell: CGSize(width: 140, height: 260))]
        }
    }
    
}

struct HomeSectionSize {
    var size: [SectionSize]
    
    init(type: SectionType) {
        self.size = type.size
    }
}
