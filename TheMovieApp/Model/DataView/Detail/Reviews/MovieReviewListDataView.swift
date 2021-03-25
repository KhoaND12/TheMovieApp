//
//  MovieReviewListDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

protocol MovieReviewListDataType {
    var id: Int? { get }
    var results: [MovieReviewDataType] { get }
}

class MovieReviewListDataView: MovieReviewListDataType {
    var id: Int?
    var results: [MovieReviewDataType] = []
    
    init(model: MovieReviewListModel) {
        self.results = model.results.orArrEmpty.compactMap { MovieReviewDataView(input: $0) }
        self.id = model.id
    }
}
