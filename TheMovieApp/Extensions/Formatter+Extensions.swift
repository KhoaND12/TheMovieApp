//
//  Formatter+Extensions.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import Foundation

//MARK:-DATE'S FORMATTER
extension Formatter {
    
    static let iso8601: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = Constants.dateTimeFormat.defaultServerFormat
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        return dateFormatter
    }()
    
    static let iso8601Full: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = Constants.dateTimeFormat.defaultFullAPIFormat
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        return dateFormatter
    }()
    
    static let dateWithOnlyMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.dateFormat = Constants.dateTimeFormat.dateWithOnlyMonthFormat
        return formatter
    }()
    
}
