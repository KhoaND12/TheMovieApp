//
//  MovieVideoListModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import Foundation
import ObjectMapper

struct MovieVideoListModel: Mappable {
    var id: Int?
    var results: [MovieVideoModel]?
    
    init() { }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        results <- map["results"]
    }
}

