//
//  MovieSeriesCastDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

protocol MovieSeriesCastDataType {
    var id: Int? { get set }
    var results: [MovieActorDataType] {get set}
}

class MovieSeriesCastDataView: MovieSeriesCastDataType {
    var id: Int?
    var results: [MovieActorDataType] = []
    
    init(model: MovieSeriesCastModel) {
        self.results = model.cast.orArrEmpty.compactMap { MovieActorDataView(input: $0) }
        self.id = model.id
    }
}
