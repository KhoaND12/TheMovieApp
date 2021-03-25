//
//  CategoryViewCell.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ///
        self.contentView.addShadow(offSet: CGSize(width: 0, height: 3))
        self.containerView.addGradient()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rx.clearDisposeBag()
    }

    func bind(to data: CategoryViewCellModel) {
        data.name
            .drive(nameLabel.rx.text)
            .disposed(by: rx.disposeBag)
    }

}
