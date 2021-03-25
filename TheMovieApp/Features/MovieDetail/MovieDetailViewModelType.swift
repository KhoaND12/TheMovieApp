//
//  MovieDetailViewModelType.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import RxSwift
import RxCocoa
import DifferenceKit

// MARK: - Input
protocol MovieDetailInputType {
    var willAppear: Observable<Bool> { get }
}

struct MovieDetailInput: MovieDetailInputType {
    var willAppear: Observable<Bool>
}

// MARK: - Output
protocol MovieDetailOutputType {
    typealias Section = ArraySection<String, MovieDetailSectionModel>
    var sectionDatas: Driver<[Section]> { get }
    var loading: Observable<Bool> { get }
    
    var readMoreTrigger: AnyObserver<Void> { get }
    var backActionTrigger: AnyObserver<Void> { get }
    
}

struct MovieDetailOutput: MovieDetailOutputType {
    var sectionDatas: Driver<[Section]>
    var loading: Observable<Bool>
    
    var readMoreTrigger: AnyObserver<Void>
    var backActionTrigger: AnyObserver<Void>
}

// MARK: - HomeViewModelType
protocol MovieDetailViewModelType: ViewModelType {
    var output: MovieDetailOutputType? { get }
    
    func transform(input: MovieDetailInputType)
}
