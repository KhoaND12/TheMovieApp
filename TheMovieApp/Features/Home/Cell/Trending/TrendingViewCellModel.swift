//
//  TrendingViewCellModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import UIKit
import RxCocoa

class TrendingViewCellModel {
    
    let imageUrl: Driver<URL?>
    
    init(with model: TrendingDataType) {
        imageUrl = Driver.just(URL(string: model.posterUrl.orStringEmpty))
    }
}
