//
//  MovieReviewListModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import Foundation
import ObjectMapper

struct MovieReviewListModel: Mappable {
    var id: Int?
    var results: [MovieReviewModel]?
    
    init() { }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        results <- map["results"]
    }
}
