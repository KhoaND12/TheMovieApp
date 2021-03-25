//
//  CategoryViewCellModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import UIKit
import RxCocoa

class CategoryViewCellModel {
    
    let name: Driver<String?>
    
    init(with model: GenreDataType) {
        name = Driver.just(model.name.orStringEmpty)
    }
}
