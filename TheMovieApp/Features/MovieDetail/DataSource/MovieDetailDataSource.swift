//
//  MovieDetailDataSource.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import UIKit

extension MovieDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.section].elements[indexPath.row]
        
        switch item  {
        case .info(_, let item) :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieInfoViewCell,
                                                                for: indexPath)
                else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.bind(to: MovieInfoViewCellModel(with: item),
                      readMoreTrigger: viewModel.output?.readMoreTrigger)
            return cell
        case .rating(_, _) :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieRateViewCell,
                                                                for: indexPath)
                else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case .seriesCast(_, let items):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieActorSectionCell,
                                                                for: indexPath)
                else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.bind(to: items)
            return cell
        case .videos(_, let items):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieVideoSectionCell,
                                                                for: indexPath)
                else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.bind(to: items)
            return cell
        case .reviews(_, let item):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieReviewViewCell,
                                                                for: indexPath)
                else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 10)
            cell.bind(to: MovieReviewCellModel(with: item))
            return cell
        case .recommend(_, let items):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieRecommendSectionCell,
                                                                for: indexPath)
                else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.bind(to: items)
            return cell
        }
        
    }
}

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = data[section]
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MovieHeaderView.reuseIdentifier) as? MovieHeaderView else { return UIView() }
        
        let shouldShowMoreButton = (section.model == R.string.localizable.detailReviewSection() ||
                                        section.model == R.string.localizable.detailReviewSection() ||
                                        section.model == R.string.localizable.detailRecommendSection())
        
        headerView.bind(name: section.model, isHideMoreButton: !shouldShowMoreButton)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        
        return 48
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = data[indexPath.section].elements[indexPath.row]
        switch item {
        case .info(_, _), .reviews(_, _):
            return UITableView.automaticDimension
        case .rating(_, _):
            return 200
        case .seriesCast(_, _), .videos(_, _):
            return 180
        case .recommend(_, _):
            return 260
        }
    }
}
