//
//  String+Extensions.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import Foundation
import DifferenceKit

extension String {
    
    var iso8601: Date? {
        return Formatter.iso8601.date(from: self)
    }
    
    var iso8601Full: Date? {
        return Formatter.iso8601Full.date(from: self)
    }
    
}

//MARK: - FUNCTION
extension String {
    func chopPrefix(_ count: Int = 1) -> String {
            if count >= 0 && count <= self.count {
                let indexStartOfText = self.index(self.startIndex, offsetBy: count)
                return String(self[indexStartOfText...])
            }
            return ""
        }

        func chopSuffix(_ count: Int = 1) -> String {
            if count >= 0 && count <= self.count {
                let indexEndOfText = self.index(self.endIndex, offsetBy: -count)
                return String(self[..<indexEndOfText])
            }
            return ""
        }
}

extension String: Differentiable { }
