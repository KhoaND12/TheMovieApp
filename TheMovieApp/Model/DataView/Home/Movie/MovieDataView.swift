//
//  MovieDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 22/03/2021.
//

import DifferenceKit

//MARK: - MovieDataType
protocol MovieDataType {
    var id: Int? { get }
    var title: String? { get }
    var posterUrl: String? { get }
    
    func isEqualTo(_ other: MovieDataType) -> Bool
}

extension MovieDataType where Self: Equatable {
    func isEqualTo(_ other: MovieDataType) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}

class MovieDataView: MovieDataType, Equatable {
    
    var id: Int?
    var title: String?
    var posterUrl: String?
    
    init?(input model: MovieModel?) {
        guard let data = model, let id = data.id else { return nil }
        
        self.id = id
        self.title = data.title
        self.posterUrl = Environment.imageDomainURL.absoluteString + data.posterPath.orStringEmpty
    }
    
    static func == (lhs: MovieDataView, rhs: MovieDataView) -> Bool {
        return lhs.id.orZero == rhs.id.orZero
            && lhs.posterUrl.orStringEmpty == rhs.posterUrl.orStringEmpty
            && lhs.title.orStringEmpty == rhs.title.orStringEmpty
    }
}

extension MovieDataView: Differentiable {
    var differenceIdentifier: Int {
        return id.orZero
    }
    
    func isContentEqual(to source: MovieDataView) -> Bool {
        return self.isEqualTo(source)
    }
}
