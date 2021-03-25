//
//  MovieRateViewCell.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import UIKit
import Cosmos

class MovieRateViewCell: UITableViewCell {
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        ratingView.prepareForReuse()
    }
}
