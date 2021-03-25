//
//  TrendingViewCell.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import UIKit
import RxCocoa

class TrendingViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.addShadow(offSet: CGSize(width: 0, height: 3))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rx.clearDisposeBag()
    }

    func bind(to data: TrendingViewCellModel) {
        data.imageUrl
            .drive(imageView.rx.imageURL(withPlaceholder: nil,
                                            options: [.transition(.fade(0.25)),
                                                      .cacheMemoryOnly]))
            .disposed(by: rx.disposeBag)
    }
    
}
