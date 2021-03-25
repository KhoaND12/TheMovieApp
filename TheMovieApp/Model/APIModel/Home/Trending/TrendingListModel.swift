//
//  TrendingListModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import Foundation
import ObjectMapper

struct TrendingListModel: Mappable {
    var results: [TrendingModel]?
    var totalResults: Int?
    
    init() { }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        results <- map["results"]
        totalResults <- map["total_results"]
    }
}
