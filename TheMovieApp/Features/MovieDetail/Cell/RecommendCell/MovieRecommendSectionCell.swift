//
//  MovieRecommendSectionCell.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import UIKit
import RxSwift
import DifferenceKit

class MovieRecommendSectionCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 16,
                                                       bottom: 0, right: 16)
            collectionView.register(R.nib.movieRecommedCell)
            collectionView.decelerationRate = .fast
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    // MARK: - Private properties
    typealias Section = ArraySection<String, MovieDataView>
    internal var data = [Section]()
    private var dataInput: [Section] {
        get { return data }
        set {
            let changeset = StagedChangeset(source: data, target: newValue)
            collectionView.reload(using: changeset) { data in self.data = data }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rx.clearDisposeBag()
    }

    func bind(to newItems: [MovieDataType]) {
        dataInput = [ArraySection(model: MovieRecommendSectionCell.typeName,
                                  elements: newItems.compactMap { $0 as? MovieDataView })]
    }
    
}

// MARK: - UICollectionViewDataSource
extension MovieRecommendSectionCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return data[section].elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.movieRecommedCell,
                                                            for: indexPath)
            else { return UICollectionViewCell() }
        let item = data[indexPath.section].elements[indexPath.row]
        cell.bind(to: MovieViewCellModel(with: item))
        return cell
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension MovieRecommendSectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Constants.ScreenSize.Width - 72) / 3, height: ((Constants.ScreenSize.Width - 72) / 3) * 150/100 + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
