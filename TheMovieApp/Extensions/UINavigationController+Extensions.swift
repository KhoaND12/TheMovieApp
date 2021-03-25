//
//  UINavigationController+Extensions.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 22/03/2021.
//

import UIKit

extension UINavigationController {
    func addShadow() {
        self.navigationBar.layer.masksToBounds = false
        self.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationBar.layer.shadowOpacity = 0.8
        self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.navigationBar.layer.shadowRadius = 2
    }
}
