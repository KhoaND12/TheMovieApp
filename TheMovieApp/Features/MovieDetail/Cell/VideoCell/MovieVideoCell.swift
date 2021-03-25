//
//  MovieVideoCell.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import UIKit

class MovieVideoCell: UICollectionViewCell {
    @IBOutlet weak var imageVideoView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.addShadow(color: UIColor.black, offSet: CGSize(width: 0, height: 3))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rx.clearDisposeBag()
    }
    
    func bind(to data: MovieVideoCellModelType) {
        data.thumnailUrl
            .drive(imageVideoView.rx.imageURL(withPlaceholder: nil,
                                            options: [.transition(.fade(0.25)),
                                                      .cacheMemoryOnly]))
            .disposed(by: rx.disposeBag)
    }

}
