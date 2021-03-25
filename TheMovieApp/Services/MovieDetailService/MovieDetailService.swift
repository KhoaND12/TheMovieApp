//
//  MovieDetailService.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import UIKit
import RxSwift

protocol MovieDetailServiceType {
    func fetchDetail(movieId: Int) -> Single<MovieInfoModel>
    func fetchSeriesCast(movieId: Int) -> Single<MovieSeriesCastModel>
    func fetchVideos(movieId: Int) -> Single<MovieVideoListModel>
    func fetchReviews(movieId: Int) -> Single<MovieReviewListModel>
    func fetchRecommends(movieId: Int) -> Single<MovieListModel>
}

class MovieDetailService: MovieDetailServiceType, NetworkingType {
    
    let provider: ApiProvider<MovieDetailAPI>
    
    init() {
        provider = ApiProvider(plugins: MovieDetailService.plugins)
    }
    
    func fetchDetail(movieId: Int) -> Single<MovieInfoModel> {
        return provider.requestObject(.detail(id: movieId), type: MovieInfoModel.self)
    }
    
    func fetchSeriesCast(movieId: Int) -> Single<MovieSeriesCastModel> {
        return provider.requestObject(.seriesCasts(id: movieId), type: MovieSeriesCastModel.self)
    }
    
    func fetchVideos(movieId: Int) -> Single<MovieVideoListModel> {
        return provider.requestObject(.videos(id: movieId), type: MovieVideoListModel.self)
    }
    
    func fetchReviews(movieId: Int) -> Single<MovieReviewListModel> {
        return provider.requestObject(.reviews(id: movieId), type: MovieReviewListModel.self)
    }
    
    func fetchRecommends(movieId: Int) -> Single<MovieListModel> {
        return provider.requestObject(.recommends(id: movieId), type: MovieListModel.self)
    }
}
