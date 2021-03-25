//
//  MovieViewCell.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import UIKit

class MovieViewCell: UICollectionViewCell {
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ///
        self.imageContainerView.addShadow(offSet: CGSize(width: 0, height: 3))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rx.clearDisposeBag()
    }
    
    func bind(to data: MovieViewCellModel) {
        data.title
            .drive(titleLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        data.imageUrl
            .drive(imageView.rx.imageURL(withPlaceholder: nil,
                                            options: [.transition(.fade(0.25)),
                                                      .cacheMemoryOnly]))
            .disposed(by: rx.disposeBag)
    }

}
