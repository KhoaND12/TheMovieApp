//
//  MovieActorCell.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import UIKit

class MovieActorCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ///
        imageContainerView.addShadow(offSet: CGSize(width: 0, height: 2))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rx.clearDisposeBag()
    }
    
    func bind(to data: MovieActorCellModelType) {
        rx.disposeBag.insert (
            data.profileUrl
                .drive(imageView.rx.imageURL(withPlaceholder: nil,
                                                options: [.transition(.fade(0.25)),
                                                          .cacheMemoryOnly])),
            data.name.drive(nameLabel.rx.text),
            data.character.drive(characterLabel.rx.text)
        )
    }
}
