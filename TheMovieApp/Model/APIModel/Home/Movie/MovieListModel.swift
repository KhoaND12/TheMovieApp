//
//  PopularListModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 22/03/2021.
//

import Foundation
import ObjectMapper

struct MovieListModel: Mappable {
    var results: [MovieModel]?
    var page: Int?
    var totalPages: Int?
    
    init() { }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        results <- map["results"]
        page <- map["page"]
        totalPages <- map["total_pages"]
    }
}
