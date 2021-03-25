//
//  MovieVideoSectionCell.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 24/03/2021.
//

import UIKit
import RxSwift
import DifferenceKit

class MovieVideoSectionCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 16,
                                                       bottom: 0, right: 16)
            collectionView.register(R.nib.movieVideoCell)
            collectionView.decelerationRate = .fast
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    // MARK: - Private properties
    typealias Section = ArraySection<String, MovieVideoDataView>
    private var data = [Section]()
    private var dataInput: [Section] {
        get { return data }
        set {
            let changeset = StagedChangeset(source: data, target: newValue)
            collectionView.reload(using: changeset) { data in self.data = data }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rx.clearDisposeBag()
    }

    func bind(to newItems: [MovieVideoDataType]) {
        dataInput = [ArraySection(model: MovieVideoSectionCell.typeName,
                                  elements: newItems.compactMap { $0 as? MovieVideoDataView })]
    }
}

// MARK: - UICollectionViewDataSource
extension MovieVideoSectionCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return data[section].elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.movieVideoCell,
                                                            for: indexPath)
            else { return UICollectionViewCell() }
        let item = data[indexPath.section].elements[indexPath.row]
        cell.bind(to: MovieVideoCellModel(with: item))
        return cell
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension MovieVideoSectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 120)
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

