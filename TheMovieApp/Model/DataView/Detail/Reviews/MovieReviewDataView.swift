//
//  MovieReviewDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import DifferenceKit

protocol MovieReviewDataType {
    var id: String? { get }
    var author: String? { get }
    var content: String? { get }
    var avatar: String? { get }
    var rating: Int? { get }
    var createdDate: Date? { get }
    
    func isEqualTo(_ other: MovieReviewDataType) -> Bool
}

extension MovieReviewDataType where Self: Equatable {
    func isEqualTo(_ other: MovieReviewDataType) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}

struct MovieReviewDataView: MovieReviewDataType, Equatable {
    
    var id: String?
    var author: String?
    var content: String?
    var avatar: String?
    var rating: Int?
    var createdDate: Date?
    
    init(input model: MovieReviewModel?) {
        guard let data = model, let id = data.id else { return }
        
        self.id = id
        self.author = data.author
        self.content = data.content
        self.avatar = data.avatar.orStringEmpty.contains("https") ? String(data.avatar.orStringEmpty.dropFirst()) : Environment.imageDomainURL.absoluteString + data.avatar.orStringEmpty
        self.rating = data.rating
        self.createdDate = data.createdAt.orStringEmpty.iso8601Full
    }
    
    static func == (lhs: MovieReviewDataView, rhs: MovieReviewDataView) -> Bool {
        return lhs.id.orStringEmpty == rhs.id.orStringEmpty
            && lhs.author.orStringEmpty == rhs.author.orStringEmpty
            && lhs.content.orStringEmpty == rhs.content.orStringEmpty
            && lhs.avatar.orStringEmpty == rhs.avatar.orStringEmpty
            && lhs.rating.orZero == rhs.rating.orZero
            && lhs.createdDate.orCurrent == rhs.createdDate.orCurrent
    }
}

extension MovieReviewDataView: Differentiable {
    var differenceIdentifier: String {
        return id.orStringEmpty
    }
    
    func isContentEqual(to source: MovieReviewDataView) -> Bool {
        return self.isEqualTo(source)
    }
}

extension MovieReviewDataView: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id.orStringEmpty)
        hasher.combine(author.orStringEmpty)
        hasher.combine(content.orStringEmpty)
        hasher.combine(avatar.orStringEmpty)
        hasher.combine(rating.orZero)
    }
}
