//
//  MovieReviewCellModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import RxCocoa

protocol MovieReviewCellModelType {
    var avatarUrl: Driver<URL?> { get }
    var name: Driver<String?> { get }
    var content: Driver<String?> { get }
    var rating: Driver<String?> { get }
    var dateReview: Driver<String?> { get }
}

class MovieReviewCellModel: MovieReviewCellModelType {
    var avatarUrl: Driver<URL?>
    var name: Driver<String?>
    var content: Driver<String?>
    var rating: Driver<String?>
    var dateReview: Driver<String?>
    
    init(with model: MovieReviewDataType) {
        avatarUrl = Driver.just(URL(string: model.avatar.orStringEmpty))
        name = Driver.just(model.author.orStringEmpty)
        content = Driver.just(model.content.orStringEmpty)
        rating = Driver.just("\(model.rating.orZero)")
        dateReview = Driver.just(model.createdDate?.getHisoryReadTime())
    }
}
