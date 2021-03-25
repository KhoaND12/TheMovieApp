//
//  HomeService.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import UIKit
import RxSwift

protocol HomeServiceType {
    func fetchTrending() -> Single<TrendingListModel>
    func fetchGenres() -> Single<GenreListModel>
    func fetchPopular(offset: Int) -> Single<MovieListModel>
    func fetchTopRated(offset: Int) -> Single<MovieListModel>
    func fetchUpComing(offset: Int) -> Single<MovieListModel>
}

class HomeService: HomeServiceType, NetworkingType {
    
    let provider: ApiProvider<HomeAPI>
    
    init() {
        provider = ApiProvider(plugins: HomeService.plugins)
    }
    
    func fetchTrending() -> Single<TrendingListModel> {
        return provider.requestObject(.trending, type: TrendingListModel.self)
    }
    
    func fetchGenres() -> Single<GenreListModel> {
        return provider.requestObject(.category, type: GenreListModel.self)
    }
    
    func fetchPopular(offset: Int) -> Single<MovieListModel> {
        return provider.requestObject(.popular(offset: offset), type: MovieListModel.self)
    }
    
    func fetchTopRated(offset: Int) -> Single<MovieListModel> {
        return provider.requestObject(.topRated(offset: offset), type: MovieListModel.self)
    }
    
    func fetchUpComing(offset: Int) -> Single<MovieListModel> {
        return provider.requestObject(.upcoming(offset: offset), type: MovieListModel.self)
    }
}

