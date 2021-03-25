//
//  MovieDetailSectionModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import DifferenceKit

enum MovieDetailSectionModel: Differentiable {
    case info(title: String, item: MovieInfoDataType)
    case rating(title: String, item: String)
    case seriesCast(title: String, item: [MovieActorDataType])
    case videos(title: String, item: [MovieVideoDataType])
    case reviews(title: String, item: MovieReviewDataType)
    case recommend(title: String, item: [MovieDataType])
    
    var differenceIdentifier: Int {
        switch self {
        case .info(let title, _):
            return title.hashValue
        case .rating(let title, _):
            return title.hashValue
        case .seriesCast(let title, _):
            return title.hashValue
        case .videos(let title, _):
            return title.hashValue
        case .reviews(let title, _):
            return title.hashValue
        case .recommend(let title, _):
            return title.hashValue
        }
    }
    
    func isContentEqual(to source: MovieDetailSectionModel) -> Bool {
        switch (self, source) {
        case (.info(_, let item1), .info(_, let item2)):
            return item1.isEqualTo(item2)
        case (.rating(_, let item1), .rating(_, let item2)):
            return item1 == item2
        case (.reviews(_, let item1), .reviews(_, let item2)):
            return item1.isEqualTo(item2)
        default:
            return false
        }
    }
    
    var infoItem: MovieInfoDataType {
        switch self {
        case .info(_, let item):
            return item
        default:
            return MovieInfoDataView(input: nil)
        }
    }
}
