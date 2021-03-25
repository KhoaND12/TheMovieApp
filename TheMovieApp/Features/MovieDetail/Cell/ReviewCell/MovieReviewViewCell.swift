//
//  MovieReviewViewCell.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import UIKit
import Cosmos

class MovieReviewViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rx.clearDisposeBag()
    }
    
    func bind(to data: MovieReviewCellModelType) {
        rx.disposeBag.insert (
            data.avatarUrl
                .drive(avatarImageView.rx.imageURL(withPlaceholder: nil,
                                                options: [.transition(.fade(0.25)),
                                                          .cacheMemoryOnly])),
            data.name.drive(authorNameLabel.rx.text),
            data.content.drive(contentLabel.rx.text),
            data.rating.drive(ratingLabel.rx.text),
            data.dateReview.drive(dateLabel.rx.text)
        )
    }
    
}
