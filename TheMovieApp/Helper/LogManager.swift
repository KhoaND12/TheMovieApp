//
//  LogManager.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import UIKit

public func logDebug(_ message: @autoclosure () -> String) {
    if !Environment.current.enableLogger { return }
    print("DEBUG: " + message())
}

public func logError(_ message: @autoclosure () -> String) {
    if !Environment.current.enableLogger { return }
    print("Error: " + message())
}

public func logInfo(_ message: @autoclosure () -> String) {
    if !Environment.current.enableLogger { return }
    print("Info: " + message())
}

public func logWarn(_ message: @autoclosure () -> String) {
    if !Environment.current.enableLogger { return }
    print("Warn: " + message())
}

