//
//  MovieInfoViewCell.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import UIKit
import Cosmos
import RxSwift
import SnapKit

class MovieInfoViewCell: UITableViewCell {
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    private lazy var genresStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 5
        return stackView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ratingView.isUserInteractionEnabled = false
        setupGenresStackView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ratingView.prepareForReuse()
        genresStackView.removeAllArrangedView()
        rx.clearDisposeBag()
    }
    
    private func setupGenresStackView() {
        self.contentView.addSubview(genresStackView)
        genresStackView.translatesAutoresizingMaskIntoConstraints = false
        genresStackView.snp.makeConstraints { [weak self] (make) in
            guard let `self` = self else { return }
            make.height.equalTo(22)
            make.top.equalTo(self.releaseDateLabel.snp.bottom).offset(10)
            make.left.equalTo(self.posterImage.snp.right).offset(10)
        }
    }
    
    func bind(to data: MovieInfoViewCellModelType, readMoreTrigger: AnyObserver<Void>?) {
        rx.disposeBag.insert (
            data.backdropUrl
                .drive(backdropImage.rx.imageURL(withPlaceholder: nil,
                                                options: [.transition(.fade(0.25)),
                                                          .cacheMemoryOnly])),
            
            data.posterUrl
                .drive(posterImage.rx.imageURL(withPlaceholder: nil,
                                                options: [.transition(.fade(0.25)),
                                                          .cacheMemoryOnly])),
            
            data.title
                .drive(titleLabel.rx.text),
            data.overview
                .drive(overviewLabel.rx.text),
            data.releaseDate
                .drive(releaseDateLabel.rx.text),
            data.rating
                .drive(ratingLabel.rx.text),
            data.isReadMore
                .map { $0 ? 0 : 5 }
                .drive(overviewLabel.rx.numberOfline()),
            data.isReadMore
                .drive(readMoreButton.rx.isHidden),
            data.genres
                .drive(genresStackView.rx.genresTitles)
        )
        
        guard let unwrapReadMoreTrigger = readMoreTrigger else { return }
        
        readMoreButton.rx.tap
            .bind(to: unwrapReadMoreTrigger)
            .disposed(by: rx.disposeBag)
    }

}
