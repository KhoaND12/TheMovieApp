//
//  HomeDataSource.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import UIKit
import DifferenceKit

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return data[section].elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch data[indexPath.section].elements[indexPath.row] {
        case .trending(_, let items, _):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.trendingViewSectionCell,
                                                                for: indexPath)
                else { return UICollectionViewCell() }
            cell.bind(to: items,
                      itemSelectedTrigger: viewModel.output?.itemDetailTrigger)
            return cell
        case .category(_, let items, _):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.categoryViewSectionCell,
                                                                for: indexPath)
                else { return UICollectionViewCell() }
            cell.bind(to: items)
            return cell
        case .popular(_, let items, _):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier.popularCell,
                                                                for: indexPath) as? MovieViewSectionCell
            else { return UICollectionViewCell() }
            
            cell.bindModel(type: .popular(offset: 0),
                           items: items,
                           itemSelectedTrigger: viewModel.output?.itemDetailTrigger,
                           loadMoreSubject: viewModel.output?.loadMorePopularSub)
            return cell
        case .topRated(_, let items, _):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier.topRatedCell,
                                                                for: indexPath) as? MovieViewSectionCell
            else { return UICollectionViewCell() }
            
            cell.bindModel(type: .topRated(offset: 0),
                           items: items,
                           itemSelectedTrigger: viewModel.output?.itemDetailTrigger,
                           loadMoreSubject: viewModel.output?.loadMoreTopRatedSub)
            return cell
        case .upComing(_, let items, _):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier.upComingCell,
                                                                for: indexPath) as? MovieViewSectionCell
            else { return UICollectionViewCell() }
            
            cell.bindModel(type: .upComing(offset: 0),
                           items: items,
                           itemSelectedTrigger: viewModel.output?.itemDetailTrigger,
                           loadMoreSubject: viewModel.output?.loadMoreUpComingSub)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sectionSize(at: indexPath)
    }
    
    private func sectionSize(at index: IndexPath) -> CGSize {
        guard let sectionSize = data[safe: index.section]?.elements[safe: index.row]?.sectionSize, !sectionSize.size.isEmpty else {
            return CGSize(width: Constants.ScreenSize.Width, height: 0)
        }
        
        let sizeResult = sectionSize.size.reduce(CGSize(width: Constants.ScreenSize.Width,
                                                        height: 6)) { (result, next) -> CGSize in
                                                            return CGSize(width: next.section.width,
                                                                          height: result.height + next.section.height)
                                                }
        
        return sizeResult
    }
}
