//
//  AppCoordinator.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 17/03/2021.
//

import UIKit
import XCoordinator
import Resolver
import RxSwift

enum AppRoute: Route {
    case main
    case detail(movieId: Int)
    case backToRoot
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    // MARK: Initialization
    var strongMainRouter: StrongRouter<AppRoute>!
    
    init() {
        super.init(initialRoute: .main)
    }
    
    // MARK: Overrides
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .main:
            let viewController = R.storyboard.movie.homeViewController()!
            viewController.bind(to: HomeViewModel(router: unownedRouter))
            return .push(viewController)
        case .detail(let id):
            let viewController = R.storyboard.movie.movieDetailViewController()!
            viewController.bind(to: MovieDetailViewModel(router: unownedRouter, movieId: id))
            return .push(viewController)
        case .backToRoot:
            return .popToRoot()
        }
    }
    
}
