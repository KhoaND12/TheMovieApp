//
//  TrendingListDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

protocol TrendingListDataType {
    var totalResults: Int? { get set }
    var results: [TrendingDataType] {get set}
}

class TrendingListDataView: TrendingListDataType {
    var totalResults: Int?
    var results: [TrendingDataType] = []
    
    init(model: TrendingListModel) {
        self.results = model.results.orArrEmpty.compactMap { TrendingDataView(input: $0) }
        self.totalResults = model.totalResults
    }
}
