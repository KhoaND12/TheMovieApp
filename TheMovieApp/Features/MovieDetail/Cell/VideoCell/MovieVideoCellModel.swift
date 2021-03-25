//
//  MovieVideoCellModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import RxCocoa

protocol MovieVideoCellModelType {
    var thumnailUrl: Driver<URL?> { get }
}

class MovieVideoCellModel: MovieVideoCellModelType {
    var thumnailUrl: Driver<URL?>
    
    init(with model: MovieVideoDataType) {
        thumnailUrl = Driver.just(URL(string: model.linkThumb.orStringEmpty))
    }
}
