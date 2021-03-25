//
//  UIStackView+Extensions.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 25/03/2021.
//

import UIKit

extension UIStackView {
    
    func removeAllArrangedView() {
        for item in arrangedSubviews {
            removeArrangedSubview(item)
            NSLayoutConstraint.deactivate(item.constraints)
            item.removeFromSuperview()
        }
    }
}
