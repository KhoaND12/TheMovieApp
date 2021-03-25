//
//  Environment.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import UIKit

enum Environment {
    case debug
    case release
    
    static var current: Environment {
        get {
            #if DEBUG
            return Environment.debug
            #else
            return Environment.release
            #endif
        }
    }
    
}

// MARK: - Flag config
extension Environment {
    var logNetworking: Bool { return Environment.current == .debug }
    var enableLogger: Bool { return Environment.current == .debug }
}
