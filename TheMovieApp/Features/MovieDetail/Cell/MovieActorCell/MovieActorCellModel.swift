//
//  MovieActorCellViewModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import RxCocoa

protocol MovieActorCellModelType {
    var name: Driver<String> { get }
    var character: Driver<String> { get }
    var profileUrl: Driver<URL?> { get }
}

class MovieActorCellModel: MovieActorCellModelType {
    var name: Driver<String>
    var character: Driver<String>
    var profileUrl: Driver<URL?>
    
    init(with model: MovieActorDataType) {
        name = Driver.just(model.name.orStringEmpty)
        character = Driver.just(model.character.orStringEmpty)
        profileUrl = Driver.just(URL(string: model.profilePath.orStringEmpty))
    }
}
