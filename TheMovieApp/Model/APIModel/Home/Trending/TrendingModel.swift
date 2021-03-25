//
//  TrendingModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import ObjectMapper

struct TrendingModel: Mappable {
    
    var id: Int?
    var title: String?
    var backdropPath: String?
    
    init?(map: Map) { }
    
    init() { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        backdropPath <- map["backdrop_path"]
    }
}
