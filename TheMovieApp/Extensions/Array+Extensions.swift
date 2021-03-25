//
//  Array+Extensions.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import Foundation

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
    
    func isDifference(from other: [Element]) -> Bool {
        return !difference(from: other).isEmpty
    }
    
    func intersection(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.intersection(otherSet))
    }
    
    func difference(to other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.subtracting(otherSet))
    }
    
    func isDifference(to other: [Element]) -> Bool {
        return !difference(to: other).isEmpty
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return 0..<count ~= index ? self[index] : nil
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
