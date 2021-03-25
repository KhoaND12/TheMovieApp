//
//  MovieInfoViewCellModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import RxCocoa

protocol MovieInfoViewCellModelType {
    var id: Driver<Int> { get }
    var title: Driver<String> { get }
    var overview: Driver<String> { get }
    var backdropUrl: Driver<URL?> { get }
    var posterUrl: Driver<URL?> { get }
    var rating: Driver<String> { get }
    var releaseDate: Driver<String> { get }
    var isReadMore: Driver<Bool> { get }
    var genres: Driver<[GenreDataType]> { get}
}

class MovieInfoViewCellModel: MovieInfoViewCellModelType {
    var id: Driver<Int>
    var title: Driver<String>
    var overview: Driver<String>
    var backdropUrl: Driver<URL?>
    var posterUrl: Driver<URL?>
    var rating: Driver<String>
    var releaseDate: Driver<String>
    var isReadMore: Driver<Bool>
    var genres: Driver<[GenreDataType]>
    
    init(with model: MovieInfoDataType) {
        id = Driver.just(model.id.orZero)
        title = Driver.just(model.title.orStringEmpty)
        overview = Driver.just(model.overview.orStringEmpty)
        backdropUrl = Driver.just(URL(string: model.backdropUrl.orStringEmpty))
        posterUrl = Driver.just(URL(string: model.posterUrl.orStringEmpty))
        rating = Driver.just("\(model.rating.orZero)")
        releaseDate = Driver.just(model.releaseDate.orCurrent.dateWithOnlyMonthString)
        isReadMore = Driver.just(model.isReadMore)
        genres = Driver.just(model.genres)
    }
}
