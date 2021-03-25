//
//  MovieHomeViewModelType.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import RxSwift
import RxCocoa
import DifferenceKit

// MARK: - Input
protocol HomeInputType {
    var pullToRefresh: Driver<Void> { get }
    var willAppear: Observable<Bool> { get }
}

struct HomeInput: HomeInputType {
    var pullToRefresh: Driver<Void>
    var willAppear: Observable<Bool>
}

// MARK: - Output
protocol HomeOutputType {
    typealias Section = ArraySection<HomeSectionType, HomeSectionModel>
    var reloadContent: Driver<[Section]> { get }
    var loading: Observable<Bool> { get }
    
    var loadMorePopularSub: PublishSubject<Void> { get }
    var loadMoreTopRatedSub: PublishSubject<Void> { get }
    var loadMoreUpComingSub: PublishSubject<Void> { get }
    
    var itemDetailTrigger: AnyObserver<Int> { get }
}

struct HomeOutput: HomeOutputType {
    var reloadContent: Driver<[Section]>
    var loading: Observable<Bool>
    
    var loadMorePopularSub: PublishSubject<Void>
    var loadMoreTopRatedSub: PublishSubject<Void>
    var loadMoreUpComingSub: PublishSubject<Void>
    
    var itemDetailTrigger: AnyObserver<Int>
}

// MARK: - HomeViewModelType
protocol HomeViewModelType: ViewModelType {
    var output: HomeOutputType? { get }
    
    func transform(input: HomeInputType)
}


