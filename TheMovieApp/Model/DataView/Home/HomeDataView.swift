//
//  HomeDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import UIKit

protocol HomeDataType {
    var trendingList: [TrendingDataType] { get }
    var categoryList: [GenreDataType] { get }
    var popularList: MovieListDataType { get }
    var topRatedList: MovieListDataType { get }
    var upComingList: MovieListDataType { get }
}

class HomeDataView: HomeDataType {
    
    var trendingList: [TrendingDataType]
    var categoryList: [GenreDataType]
    var popularList: MovieListDataType
    var topRatedList: MovieListDataType
    var upComingList: MovieListDataType
    
    init(input trendingList: [TrendingDataType],
         categoryList: [GenreDataType],
         popularList: MovieListDataType,
         topRatedList: MovieListDataType,
         upComingList: MovieListDataType) {
        self.trendingList = trendingList
        self.categoryList = categoryList
        self.popularList = popularList
        self.topRatedList = topRatedList
        self.upComingList = upComingList
    }
    
}
