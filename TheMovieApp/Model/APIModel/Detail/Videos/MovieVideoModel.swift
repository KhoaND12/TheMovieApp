//
//  MovieVideoModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import ObjectMapper

struct MovieVideoModel: Mappable {
    
    var id: String?
    var key: String?
    var name: String?
    
    init?(map: Map) { }
    
    init() { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        key <- map["key"]
    }
}
