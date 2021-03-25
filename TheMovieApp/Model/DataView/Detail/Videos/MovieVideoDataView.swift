//
//  MovieVideoDataView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import DifferenceKit

protocol MovieVideoDataType {
    var id: String? { get }
    var name: String? { get }
    var linkThumb: String? { get }
    
    func isEqualTo(_ other: MovieVideoDataType) -> Bool
}

extension MovieVideoDataType where Self: Equatable {
    func isEqualTo(_ other: MovieVideoDataType) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}

struct MovieVideoDataView: MovieVideoDataType, Equatable {
    
    var id: String?
    var name: String?
    var linkThumb: String?
    
    init(input model: MovieVideoModel?) {
        guard let data = model, let id = data.id else { return }
        
        self.id = id
        self.name = data.name
        self.linkThumb = Environment.videoDomainURL.absoluteString + data.key.orStringEmpty + Constants.videoResolution.full
    }
    
    static func == (lhs: MovieVideoDataView, rhs: MovieVideoDataView) -> Bool {
        return lhs.id.orStringEmpty == rhs.id.orStringEmpty
            && lhs.linkThumb.orStringEmpty == rhs.linkThumb.orStringEmpty
            && lhs.name.orStringEmpty == rhs.name.orStringEmpty
    }
}

extension MovieVideoDataView: Differentiable {
    var differenceIdentifier: String {
        return id.orStringEmpty
    }
    
    func isContentEqual(to source: MovieVideoDataView) -> Bool {
        return self.isEqualTo(source)
    }
}
