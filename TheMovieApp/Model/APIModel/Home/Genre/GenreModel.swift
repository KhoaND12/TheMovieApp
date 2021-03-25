//
//  GenreModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import ObjectMapper

struct GenreModel: Mappable {
    
    var id: Int?
    var name: String?
    
    init?(map: Map) { }
    
    init() { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

