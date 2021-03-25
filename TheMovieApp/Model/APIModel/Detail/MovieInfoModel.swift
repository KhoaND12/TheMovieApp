//
//  MovieDetailModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import ObjectMapper

struct MovieInfoModel: Mappable {
    
    var id: Int?
    var title: String?
    var overview: String?
    var backdropPath: String?
    var posterPath: String?
    var rating: Int?
    var genres: [GenreModel]?
    var releaseDate: String?
    
    init?(map: Map) { }
    
    init() { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["original_title"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        backdropPath <- map["backdrop_path"]
        rating <- map["vote_average"]
        genres <- map["genres"]
        releaseDate <- map["release_date"]
    }
}

