//
//  MovieHeaderView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import UIKit

class MovieHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    static let reuseIdentifier = "MovieHeaderView"
    
    
    func bind(name: String, isHideMoreButton: Bool = true) {
        titleLabel.text = name
        moreButton.isHidden = isHideMoreButton
    }
}
