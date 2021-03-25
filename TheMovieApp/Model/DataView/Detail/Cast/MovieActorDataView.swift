//
//  MovieActorDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import DifferenceKit

protocol MovieActorDataType {
    var id: Int? { get }
    var name: String? { get }
    var character: String? { get }
    var profilePath: String? { get }
    
    func isEqualTo(_ other: MovieActorDataType) -> Bool
}

extension MovieActorDataType where Self: Equatable {
    func isEqualTo(_ other: MovieActorDataType) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}

struct MovieActorDataView: MovieActorDataType, Equatable {
    
    var id: Int?
    var name: String?
    var character: String?
    var profilePath: String?
    
    init(input model: MovieActorModel?) {
        guard let data = model, let id = data.id else { return }
        
        self.id = id
        self.name = data.name
        self.character = data.character
        self.profilePath = Environment.imageDomainURL.absoluteString + data.profilePath.orStringEmpty
    }
    
    static func == (lhs: MovieActorDataView, rhs: MovieActorDataView) -> Bool {
        return lhs.id.orZero == rhs.id.orZero
            && lhs.profilePath.orStringEmpty == rhs.profilePath.orStringEmpty
            && lhs.name.orStringEmpty == rhs.name.orStringEmpty
            && lhs.character.orStringEmpty == rhs.character.orStringEmpty
    }
}

extension MovieActorDataView: Differentiable {
    var differenceIdentifier: Int {
        return id.orZero
    }
    
    func isContentEqual(to source: MovieActorDataView) -> Bool {
        return self.isEqualTo(source)
    }
}
