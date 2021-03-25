//
//  Constants.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import Foundation
import UIKit

struct Constants {
    static let maxItem = 3
    
    struct ScreenSize {
        static let Width = UIScreen.main.bounds.width
        static let Height = UIScreen.main.bounds.height
    }
    
    struct dateTimeFormat {
        static let defaultServerFormat = "yyyy-MM-dd"
        static let defaultFullAPIFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        static let dateWithOnlyMonthFormat = "MMMM yyyy"
    }
    
    struct reuseIdentifier {
        static let popularCell = "popularCell"
        static let topRatedCell = "topRatedCell"
        static let upComingCell = "upComingCell"
    }
    
    struct videoResolution {
        static let full = "/maxresdefault.jpg"
    }
}
