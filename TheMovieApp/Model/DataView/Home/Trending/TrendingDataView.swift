//
//  TrendingDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import DifferenceKit

//MARK: - EventDataType
protocol TrendingDataType {
    var id: Int? { get }
    var title: String? { get }
    var posterUrl: String? { get }
    
    func isEqualTo(_ other: TrendingDataType) -> Bool
}

extension TrendingDataType where Self: Equatable {
    func isEqualTo(_ other: TrendingDataType) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}

class TrendingDataView: TrendingDataType, Equatable {
    
    var id: Int?
    var title: String?
    var posterUrl: String?
    
    init?(input model: TrendingModel?) {
        guard let data = model, let id = data.id else { return nil }
        
        self.id = id
        self.title = data.title
        self.posterUrl = Environment.imageDomainURL.absoluteString + data.backdropPath.orStringEmpty
    }
    
    static func == (lhs: TrendingDataView, rhs: TrendingDataView) -> Bool {
        return lhs.id.orZero == rhs.id.orZero
            && lhs.posterUrl.orStringEmpty == rhs.posterUrl.orStringEmpty
            && lhs.title.orStringEmpty == rhs.title.orStringEmpty
    }
}

extension TrendingDataView: Differentiable {
    var differenceIdentifier: Int {
        return id.orZero
    }
    
    func isContentEqual(to source: TrendingDataView) -> Bool {
        return self.isEqualTo(source)
    }
}
