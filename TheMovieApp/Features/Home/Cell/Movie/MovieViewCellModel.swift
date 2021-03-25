//
//  MovieViewCellModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 22/03/2021.
//

import UIKit
import RxCocoa

class MovieViewCellModel {
    
    let title: Driver<String?>
    let imageUrl: Driver<URL?>
    
    init(with model: MovieDataType) {
        title = Driver.just(model.title.orStringEmpty)
        imageUrl = Driver.just(URL(string: model.posterUrl.orStringEmpty))
    }
}
