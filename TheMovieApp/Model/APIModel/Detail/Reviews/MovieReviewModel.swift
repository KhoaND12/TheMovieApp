//
//  MovieReviewModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import ObjectMapper

struct MovieReviewModel: Mappable {
    
    var id: String?
    var content: String?
    var author: String?
    var rating: Int?
    var createdAt: String?
    var avatar: String?
    
    init?(map: Map) { }
    
    init() { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        author <- map["author"]
        rating <- map["author_details.rating"]
        createdAt <- map["created_at"]
        avatar <- map["author_details.avatar_path"]
    }
}
