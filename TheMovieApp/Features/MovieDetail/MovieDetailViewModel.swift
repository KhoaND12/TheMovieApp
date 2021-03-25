//
//  MovieDetailViewModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import RxCocoa
import RxSwift
import Resolver
import XCoordinator
import Action
import DifferenceKit
import ObjectMapper

class MovieDetailViewModel: ViewModel, MovieDetailViewModelType {
    var output: MovieDetailOutputType?
    
    typealias Section = MovieDetailOutputType.Section
    
    // MARK: Private properties
    @LazyInjected(container: .services)
    private var apiService: MovieDetailServiceType
    
    private var sectionData = BehaviorRelay<[Section]>(value: [])
    private let router: UnownedRouter<AppRoute>
    private var movieId: Int = 0
    
    // MARK: Initialization
    init(router: UnownedRouter<AppRoute>, movieId: Int) {
        self.router = router
        self.movieId = movieId
    }
    //MARK: - ACTION
    private lazy var readMoreAction = Action<Void, [Section]> { [unowned self] in
        guard !self.sectionData.value.isEmpty else { return .just([]) }
        
        var currentValue = self.sectionData.value
        var section = currentValue[safe: 0]
        if let movieInfo = section?.elements[safe: 0]?.infoItem {
            var newInfo = movieInfo
            newInfo.isReadMore = true
            let newSectionInfo = Section.init(model: "Info",
                                              elements: [.info(title: "Info", item: newInfo)])
            currentValue.remove(at: 0)
            currentValue.insert(newSectionInfo, at: 0)
        }
        
        return .just(currentValue)
    }
    
    // MARK: - Request API
    private lazy var requestMovieDetail = Action<Void, [Section]> { [unowned self] _ in
        return Observable.zip(self.getDetail(movieId: self.movieId),
                              self.getSeriesCast(movieId: self.movieId),
                              self.getVideos(movieId: self.movieId),
                              self.getReviews(movieId: self.movieId),
                              self.getRecommends(movieId: self.movieId))
            .map { data -> MovieDetailDataType in
                let movieInfo = MovieInfoDataView(input: data.0)
                let seriesCasts = MovieSeriesCastDataView(model: data.1)
                let videoList = MovieVideoListDataView(model: data.2)
                let reviewList = MovieReviewListDataView(model: data.3)
                let recommendList = MovieListDataView(model: data.4)
                return MovieDetailDataView(input: movieInfo,
                                           casts: seriesCasts,
                                           videos: videoList,
                                           reviews: reviewList,
                                           recommends: recommendList )
                
            }.map { [weak self] data -> [Section] in
                guard let `self` = self else { return [] }
                return self.convertToSection(from: data)
            }
    }
    
    
    
    // MARK: Router
    private lazy var backAction = CocoaAction { [unowned self] in
        self.router.rx.trigger(.backToRoot)
    }
    
    // MARK: Transform
    func transform(input: MovieDetailInputType) {
        Observable.merge(input.willAppear.mapToVoid())
            .bind(to: requestMovieDetail.inputs)
            .disposed(by: rx.disposeBag)
        
        requestMovieDetail.elements
            .bind(to: sectionData)
            .disposed(by: rx.disposeBag)
        
        readMoreAction.elements
            .bind(to: sectionData)
            .disposed(by: rx.disposeBag)
        
        self.output = MovieDetailOutput(sectionDatas: sectionData.asDriver(),
                                        loading: requestMovieDetail.executing,
                                        readMoreTrigger: readMoreAction.inputs, 
                                        backActionTrigger: backAction.inputs)
    }
    
    private func convertToSection(from data: MovieDetailDataType) -> [Section] {
        var sections = [Section]()
        
        if data.info.id.orZero != 0 {
            sections.append(Section.init(model: "Info",
                                         elements: [.info(title: "Info", item: data.info)]))
            sections.append(Section.init(model: R.string.localizable.detailRateSection(),
                                          elements: [.rating(title: "Rating", item: "")]))
        }
        
        if !data.seriesCasts.results.isEmpty {
            sections.append(Section.init(model: R.string.localizable.detailCastSection(),
                                         elements: [.seriesCast(title: "Actor", item: data.seriesCasts.results)]))
        }
        
        if !data.videoList.results.isEmpty {
            sections.append(Section.init(model: R.string.localizable.detailVideoSection(),
                                         elements: [.videos(title: "Video", item: data.videoList.results)]))
        }
        
        if !data.reviewList.results.isEmpty {
            let list = Array(data.reviewList.results.prefix(Constants.maxItem))
            let reviewsSection = list.map { MovieDetailSectionModel.reviews(title: "Review id \($0.id.orStringEmpty)", item: $0) }
            
            sections.append(Section.init(model: R.string.localizable.detailReviewSection(),
                                         elements: reviewsSection))
        }
        
        if !data.recommendList.results.isEmpty {
            let list = Array(data.recommendList.results.prefix(Constants.maxItem))
            sections.append(Section.init(model: R.string.localizable.detailRecommendSection(),
                                         elements: [.recommend(title: "Recommend", item: list)]))
        }
        
       
        return sections
    }
}

// Mark: - Request API Services
extension MovieDetailViewModel {
    private func getDetail(movieId: Int) -> Observable<MovieInfoModel> {
        return apiService.fetchDetail(movieId: movieId)
            .trackError(self.error)
            .trackActivity(self.loading)
            .catchErrorJustReturn(MovieInfoModel())
    }
    
    private func getSeriesCast(movieId: Int) -> Observable<MovieSeriesCastModel> {
        return apiService.fetchSeriesCast(movieId: movieId)
            .trackError(self.error)
            .trackActivity(self.loading)
            .catchErrorJustReturn(MovieSeriesCastModel())
    }
    
    private func getVideos(movieId: Int) -> Observable<MovieVideoListModel> {
        return apiService.fetchVideos(movieId: movieId)
            .trackError(self.error)
            .trackActivity(self.loading)
            .catchErrorJustReturn(MovieVideoListModel())
    }
    
    private func getReviews(movieId: Int) -> Observable<MovieReviewListModel> {
        return apiService.fetchReviews(movieId: movieId)
            .trackError(self.error)
            .trackActivity(self.loading)
            .catchErrorJustReturn(MovieReviewListModel())
    }
    
    private func getRecommends(movieId: Int) -> Observable<MovieListModel> {
        return apiService.fetchRecommends(movieId: movieId)
            .trackError(self.error)
            .trackActivity(self.loading)
            .catchErrorJustReturn(MovieListModel())
    }
}
