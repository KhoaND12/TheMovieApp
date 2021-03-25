//
//  MovieVideoListDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

protocol MovieVideoListDataType {
    var id: Int? { get }
    var results: [MovieVideoDataType] { get }
}

class MovieVideoListDataView: MovieVideoListDataType {
    var id: Int?
    var results: [MovieVideoDataType] = []
    
    init(model: MovieVideoListModel) {
        self.results = model.results.orArrEmpty.compactMap { MovieVideoDataView(input: $0) }
        self.id = model.id
    }
}
