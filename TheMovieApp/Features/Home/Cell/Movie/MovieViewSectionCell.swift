//
//  MovieViewSectionCell.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import UIKit
import RxSwift
import DifferenceKit

class MovieViewSectionCell: UICollectionViewCell {
    @IBOutlet weak var sectionNameLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.contentInset = UIEdgeInsets(top: -10, left: 16,
                                                       bottom: 0, right: 16)
            collectionView.register(R.nib.movieViewCell)
            collectionView.decelerationRate = .fast
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    // MARK: - Private properties
    private var type: HomeSectionType = .undefined
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
    
    func bindModel(type: HomeSectionType,
                   items: [MovieDataType],
                   itemSelectedTrigger: AnyObserver<Int>?,
                   loadMoreSubject: PublishSubject<Void>?) {
        self.type = type
        sectionNameLabel.text = type.name
        dataInput = [ArraySection(model: MovieViewSectionCell.typeName,
                                  elements: items.compactMap { $0 as? MovieDataView })]
        
        guard let loadMoreUnwrap = loadMoreSubject,
              let unwrapTrigger = itemSelectedTrigger else { return }
        
        self.collectionView.rx.itemSelected
            .map { items[$0.row].id.orZero }
            .filter { $0 > 0 }
            .bind(to: unwrapTrigger)
            .disposed(by: rx.disposeBag)
        
        self.collectionView.rx.scrolledToEnd
            .bind(to: loadMoreUnwrap)
            .disposed(by: rx.disposeBag)
    }
    
}

// MARK: - UICollectionViewDataSource
extension MovieViewSectionCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return data[section].elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.movieViewCell,
                                                            for: indexPath)
            else { return UICollectionViewCell() }
        let item = data[indexPath.section].elements[indexPath.row]
        cell.bind(to: MovieViewCellModel(with: item))
        return cell
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension MovieViewSectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 260)
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
