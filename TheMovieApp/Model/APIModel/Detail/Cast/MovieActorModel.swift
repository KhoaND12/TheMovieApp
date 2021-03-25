//
//  MovieActorModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import ObjectMapper

struct MovieActorModel: Mappable {
    
    var id: Int?
    var name: String?
    var character: String?
    var profilePath: String?
    
    init?(map: Map) { }
    
    init() { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        character <- map["character"]
        profilePath <- map["profile_path"]
    }
}
