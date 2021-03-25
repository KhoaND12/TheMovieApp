//
//  MovieDetailDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import DifferenceKit

//MARK: - MovieDataType
protocol MovieInfoDataType {
    var id: Int? { get }
    var title: String? { get }
    var overview: String? { get }
    var backdropUrl: String? { get }
    var posterUrl: String? { get }
    var rating: Int? { get }
    var genres: [GenreDataType] { get set }
    var releaseDate: Date? { get }
    var isReadMore: Bool { get set }
    
    func isEqualTo(_ other: MovieInfoDataType) -> Bool
}

extension MovieInfoDataType where Self: Equatable {
    func isEqualTo(_ other: MovieInfoDataType) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}

struct MovieInfoDataView: MovieInfoDataType, Equatable {
    
    var id: Int?
    var title: String?
    var overview: String?
    var backdropUrl: String?
    var posterUrl: String?
    var rating: Int?
    var genres: [GenreDataType] = []
    var releaseDate: Date?
    var isReadMore: Bool = false
    
    init(input model: MovieInfoModel?) {
        guard let data = model, let id = data.id else { return }
        
        self.id = id
        self.title = data.title
        self.overview = data.overview
        self.backdropUrl = Environment.imageDomainURL.absoluteString + data.backdropPath.orStringEmpty
        self.posterUrl = Environment.imageDomainURL.absoluteString + data.posterPath.orStringEmpty
        self.rating = data.rating
        self.genres = data.genres.orArrEmpty.compactMap { GenreDataView(input: $0) }
        self.releaseDate = data.releaseDate?.iso8601
    }
    
    static func == (lhs: MovieInfoDataView, rhs: MovieInfoDataView) -> Bool {
        return lhs.id.orZero == rhs.id.orZero
            && lhs.posterUrl.orStringEmpty == rhs.posterUrl.orStringEmpty
            && lhs.title.orStringEmpty == rhs.title.orStringEmpty
            && lhs.overview.orStringEmpty == rhs.overview.orStringEmpty
            && lhs.backdropUrl.orStringEmpty == rhs.backdropUrl.orStringEmpty
            && lhs.rating.orZero == rhs.rating.orZero
            && lhs.releaseDate.orCurrent == rhs.releaseDate.orCurrent
            && lhs.isReadMore == rhs.isReadMore
    }
}

extension MovieInfoDataView: Differentiable {
    var differenceIdentifier: Int {
        return id.orZero
    }
    
    func isContentEqual(to source: MovieInfoDataView) -> Bool {
        return self.isEqualTo(source)
    }
}
