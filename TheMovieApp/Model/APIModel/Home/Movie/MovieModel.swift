//
//  PopularModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 22/03/2021.
//

import ObjectMapper

struct MovieModel: Mappable {
    
    var id: Int?
    var title: String?
    var posterPath: String?
    
    init?(map: Map) { }
    
    init() { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["original_title"]
        posterPath <- map["poster_path"]
    }
}
