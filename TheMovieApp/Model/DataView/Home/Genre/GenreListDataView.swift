//
//  GenreListDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

protocol GenreListDataType {
    var results: [GenreDataType] {get set}
}

class GenreListDataView: GenreListDataType {
    var results: [GenreDataType] = []
    
    init(model: GenreListModel) {
        self.results = model.results.orArrEmpty.compactMap { GenreDataView(input: $0) }
    }
}
