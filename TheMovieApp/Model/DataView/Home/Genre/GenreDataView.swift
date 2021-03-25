//
//  GenreDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import DifferenceKit

//MARK: - EventDataType
protocol GenreDataType {
    var id: Int? { get }
    var name: String? { get }
    
    func isEqualTo(_ other: GenreDataType) -> Bool
}

extension GenreDataType where Self: Equatable {
    func isEqualTo(_ other: GenreDataType) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}

struct GenreDataView: GenreDataType, Equatable {
    
    var id: Int?
    var name: String?
    
    init?(input model: GenreModel?) {
        guard let data = model, let id = data.id else { return nil }
        
        self.id = id
        self.name = data.name
    }
    
    static func == (lhs: GenreDataView, rhs: GenreDataView) -> Bool {
        return lhs.id.orZero == rhs.id.orZero
            && lhs.name.orStringEmpty == rhs.name.orStringEmpty
    }
}

extension GenreDataView: Differentiable {
    var differenceIdentifier: Int {
        return id.orZero
    }
    
    func isContentEqual(to source: GenreDataView) -> Bool {
        return self.isEqualTo(source)
    }
}
