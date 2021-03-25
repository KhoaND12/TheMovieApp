//
//  PopularListDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 22/03/2021.
//

protocol MovieListDataType {
    var page: Int? { get }
    var results: [MovieDataType] { get set }
    var totalPages: Int? { get }
}

class MovieListDataView: MovieListDataType {
    var page: Int?
    var results: [MovieDataType] = []
    var totalPages: Int?
    
    init(model: MovieListModel) {
        self.results = model.results.orArrEmpty.compactMap { MovieDataView(input: $0) }
        self.page = model.page
        self.totalPages = model.totalPages
    }
}
