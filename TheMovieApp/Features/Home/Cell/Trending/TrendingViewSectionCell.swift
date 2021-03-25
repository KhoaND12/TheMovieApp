//
//  TrendingViewSectionCell.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import UIKit
import RxSwift
import DifferenceKit

class TrendingViewSectionCell: UICollectionViewCell {
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.contentInset = UIEdgeInsets(top: -5, left: 16,
                                                       bottom: 0, right: 16)
            collectionView.register(R.nib.trendingViewCell)
            collectionView.decelerationRate = .fast
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    // MARK: - Private properties
    typealias Section = ArraySection<String, TrendingDataView>
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
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rx.clearDisposeBag()
    }
    
    func bind(to newItems: [TrendingDataType], itemSelectedTrigger: AnyObserver<Int>?) {
        dataInput = [ArraySection(model: TrendingViewSectionCell.typeName,
                                  elements: newItems.compactMap { $0 as? TrendingDataView })]
        
        guard let unwrapTrigger = itemSelectedTrigger else { return }
        
        
        collectionView.rx.itemSelected
            .map { newItems[$0.row].id.orZero }
            .filter { $0 > 0 }
            .bind(to: unwrapTrigger)
            .disposed(by: rx.disposeBag)
        
    }

}

// MARK: - UICollectionViewDataSource
extension TrendingViewSectionCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return data[section].elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.trendingViewCell,
                                                            for: indexPath)
            else { return UICollectionViewCell() }
        let item = data[indexPath.section].elements[indexPath.row]
        cell.bind(to: TrendingViewCellModel(with: item))
        return cell
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension TrendingViewSectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 160)
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
