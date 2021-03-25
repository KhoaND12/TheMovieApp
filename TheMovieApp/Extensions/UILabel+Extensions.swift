//
//  UILabel+Extensions.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 25/03/2021.
//

import UIKit

extension UILabel {
    /**
     Measure the size of some text
     */
    class func measure(text: String, font: UIFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)) -> CGSize {
        let measurementLabel = UILabel()
        measurementLabel.text = text
        measurementLabel.font = font
        return measurementLabel.intrinsicContentSize
    }
}

