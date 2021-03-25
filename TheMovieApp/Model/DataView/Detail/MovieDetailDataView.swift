//
//  MovieDetailDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import UIKit

protocol MovieDetailDataType {
    var info: MovieInfoDataType { get }
    var seriesCasts: MovieSeriesCastDataType { get }
    var videoList: MovieVideoListDataType { get }
    var reviewList: MovieReviewListDataType { get }
    var recommendList: MovieListDataType { get }
}

class MovieDetailDataView: MovieDetailDataType {
    
    var info: MovieInfoDataType
    var seriesCasts: MovieSeriesCastDataType
    var videoList: MovieVideoListDataType
    var reviewList: MovieReviewListDataType
    var recommendList: MovieListDataType
    
    init(input info: MovieInfoDataType,
         casts: MovieSeriesCastDataType,
         videos: MovieVideoListDataType,
         reviews: MovieReviewListDataType,
         recommends: MovieListDataType) {
        self.info = info
        self.seriesCasts = casts
        self.videoList = videos
        self.reviewList = reviews
        self.recommendList = recommends
    }
    
}
