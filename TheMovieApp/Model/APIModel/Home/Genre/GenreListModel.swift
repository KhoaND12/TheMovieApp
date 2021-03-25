//
//  GenreListModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import Foundation
import ObjectMapper

struct GenreListModel: Mappable {
    var results: [GenreModel]?
    
    init() { }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        results <- map["genres"]
    }
}
