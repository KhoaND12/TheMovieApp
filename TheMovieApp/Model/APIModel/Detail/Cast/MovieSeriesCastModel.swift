//
//  MovieSeriesCastModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import Foundation
import ObjectMapper

struct MovieSeriesCastModel: Mappable {
    var id: Int?
    var cast: [MovieActorModel]?
    
    init() { }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        cast <- map["cast"]
    }
}
