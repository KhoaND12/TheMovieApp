//
//  MovieHomeViewModel.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Resolver
import DifferenceKit
import XCoordinator
import Action

class HomeViewModel: ViewModel, HomeViewModelType {
    
    typealias Section = HomeOutputType.Section
    
    @LazyInjected(container: .services)
    private var apiService: HomeServiceType

    // MARK: - Private properties
    private let sectionsData = BehaviorRelay<[Section]>(value: [])
    private let loadMorePopularSubject = PublishSubject<Void>()
    private let loadMoreTopRatedSubject = PublishSubject<Void>()
    private let loadMoreUpComingSubject = PublishSubject<Void>()
    private let router: UnownedRouter<AppRoute>
    private var popularOffset = 1
    private var topRatedOffset = 1
    private var upComingOffset = 1
    
    // MARK: - Request API
    private lazy var requestHomeData = Action<Void, [Section]> { [unowned self] in
        self.resetAllOffset()
        ///
        return Observable.combineLatest(self.getTrendingList(),
                                        self.getGenreList(),
                                        self.getPopularList(offset: 1),
                                        self.getTopRatedList(offset: 1),
                                        self.getUpComingList(offset: 1))
            .map { data -> HomeDataType in
                let trendingList = TrendingListDataView(model: data.0).results
                let categoryList = GenreListDataView(model: data.1).results
                let popularList = MovieListDataView(model: data.2)
                let topRatedList = MovieListDataView(model: data.3)
                let upComingList = MovieListDataView(model: data.4)
                return HomeDataView(input: trendingList, categoryList: categoryList, popularList: popularList, topRatedList: topRatedList, upComingList: upComingList)
                
            }.map { [weak self] data -> [Section] in
                guard let `self` = self else { return [] }
                return self.convertToSection(from: data)
            }
        
    }
    
    private lazy var requestMorePopularData = Action<Int, [Section]> { [unowned self] offset in
        self.popularOffset = offset
        return self.getPopularList(offset: offset)
            .map { [weak self] data -> [Section] in
                guard let `self` = self else { return [] }
                
                let popularData = MovieListDataView(model: data)
                return self.updatePopularSection(popularList: popularData)
                
            }
    }
    
    private lazy var requestMoreTopRatedData = Action<Int, [Section]> { [unowned self] offset in
        self.topRatedOffset = offset
        return self.getTopRatedList(offset: offset)
            .map { [weak self] data -> [Section] in
                guard let `self` = self else { return [] }
                
                let topRatedData = MovieListDataView(model: data)
                return self.updateTopRatedSection(topRatedList: topRatedData)
                
            }
    }
    
    private lazy var requestMoreUpComingData = Action<Int, [Section]> { [unowned self] offset in
        self.upComingOffset = offset
        return self.getUpComingList(offset: offset)
            .map { [weak self] data -> [Section] in
                guard let `self` = self else { return [] }
                
                let upComingData = MovieListDataView(model: data)
                return self.updateUpComingSection(upComingList: upComingData)
                
            }
    }
    
    // MARK: Router
    private lazy var itemDetailAction = Action<Int, Void> { [unowned self] id in
        self.router.rx.trigger(.detail(movieId: id))
    }
    
    private func resetAllOffset() {
        self.popularOffset = 1
        self.topRatedOffset = 1
        self.upComingOffset = 1
    }
    
    // MARK: Initialization
    init(router: UnownedRouter<AppRoute>) {
        self.router = router
    }
    
    var output: HomeOutputType?
    
    func transform(input: HomeInputType) {
        let willApear = input.willAppear
            .filter { [unowned self] _ in return self.sectionsData.value.isEmpty }
            .mapToVoid()
        
        Observable.merge(willApear,
                         input.pullToRefresh.asObservable())
            .bind(to: requestHomeData.inputs)
            .disposed(by: rx.disposeBag)
        
        requestHomeData.elements
            .bind(to: sectionsData)
            .disposed(by: rx.disposeBag)
        
        /// Popular load more
        loadMorePopularSubject
            .withLatestFrom(self.sectionsData.asObservable())
            .filter { [weak self ] sectionDatas -> Bool in
                guard let `self` = self,
                      let popularSection = sectionDatas.first(where: { $0.model == HomeSectionType.popular(offset: 0) }) else { return false }
                
                return self.popularOffset < popularSection.model.pageOffset
            }.map { [unowned self] _ in return self.popularOffset + 1 }
            .bind(to: requestMorePopularData.inputs).disposed(by: rx.disposeBag)
        
        requestMorePopularData.elements
            .bind(to: sectionsData)
            .disposed(by: rx.disposeBag)
        
        /// TopRated load more
        loadMoreTopRatedSubject
            .withLatestFrom(self.sectionsData.asObservable())
            .filter { [weak self ] sectionDatas -> Bool in
                guard let `self` = self,
                      let topRatedSection = sectionDatas.first(where: { $0.model == HomeSectionType.topRated(offset: 0) }) else { return false }
                
                return self.topRatedOffset < topRatedSection.model.pageOffset
            }.map { [unowned self] _ in return self.topRatedOffset + 1 }
            .bind(to: requestMoreTopRatedData.inputs).disposed(by: rx.disposeBag)
        
        requestMoreTopRatedData.elements
            .bind(to: sectionsData)
            .disposed(by: rx.disposeBag)
        
        /// UpComing load more
        loadMoreUpComingSubject
            .withLatestFrom(self.sectionsData.asObservable())
            .filter { [weak self ] sectionDatas -> Bool in
                guard let `self` = self,
                      let upComingSection = sectionDatas.first(where: { $0.model == HomeSectionType.upComing(offset: 0) }) else { return false }
                
                return self.upComingOffset < upComingSection.model.pageOffset
            }.map { [unowned self] _ in return self.upComingOffset + 1 }
            .bind(to: requestMoreUpComingData.inputs).disposed(by: rx.disposeBag)
        
        requestMoreUpComingData.elements
            .bind(to: sectionsData)
            .disposed(by: rx.disposeBag)
        
        self.output = HomeOutput(reloadContent: sectionsData.asDriver(),
                                 loading: requestHomeData.executing,
                                 loadMorePopularSub: loadMorePopularSubject,
                                 loadMoreTopRatedSub: loadMoreTopRatedSubject,
                                 loadMoreUpComingSub: loadMoreUpComingSubject,
                                 itemDetailTrigger: itemDetailAction.inputs)
    }
    
    
    private func convertToSection(from data: HomeDataType) -> [Section] {
        var sections = [Section]()
        /// Tredings
        if !data.trendingList.isEmpty {
            sections.append(
                ArraySection(model: HomeSectionType.trending,
                             elements: [HomeSectionModel.trending(title: HomeSectionType.trending.name,
                                                                items: data.trendingList,
                                                                size: HomeSectionSize(type: .trending))])
            )
        }
        /// Genres
        if !data.categoryList.isEmpty {
            sections.append(
                ArraySection(model: HomeSectionType.category,
                             elements: [HomeSectionModel.category(title: HomeSectionType.category.name,
                                                                items: data.categoryList,
                                                                size: HomeSectionSize(type: .category))])
            )
        }
        /// Popular
        if !data.popularList.results.isEmpty {
            sections.append(
                ArraySection(model: HomeSectionType.popular(offset: data.popularList.totalPages.orZero),
                             elements: [HomeSectionModel.popular(title: HomeSectionType.popular(offset: 0).name,
                                                                 items: data.popularList.results,
                                                                 size: HomeSectionSize(type: .popular))])
            )
        }
        /// Top Rated
        if !data.topRatedList.results.isEmpty {
            sections.append(
                ArraySection(model: HomeSectionType.topRated(offset: data.topRatedList.totalPages.orZero),
                             elements: [HomeSectionModel.topRated(title: HomeSectionType.topRated(offset: 0).name,
                                                                 items: data.topRatedList.results,
                                                                 size: HomeSectionSize(type: .topRated))])
            )
        }
        /// UpComing
        if !data.upComingList.results.isEmpty {
            sections.append(
                ArraySection(model: HomeSectionType.upComing(offset: data.upComingList.totalPages.orZero),
                             elements: [HomeSectionModel.upComing(title: HomeSectionType.upComing(offset: 0).name,
                                                                 items: data.upComingList.results,
                                                                 size: HomeSectionSize(type: .upComing))])
            )
        }
        
        
        return sections
    }
    
    private func updatePopularSection(popularList: MovieListDataType) -> [Section] {
        var currentSection = self.sectionsData.value
        if let index = currentSection.firstIndex(where: { $0.model == .popular(offset: 0) }),
           let newItems = currentSection[index].elements[safe: 0]?.popularItem {
            let newData = newItems + popularList.results
            currentSection.remove(at: index)
            if !newData.isEmpty {
                
                currentSection.insert(ArraySection(model: HomeSectionType.popular(offset: popularList.totalPages.orZero),
                                                   elements: [HomeSectionModel.popular(title: HomeSectionType.popular(offset: 0).name,
                                                                                       items: newData,
                                                                                       size: HomeSectionSize(type: .popular))]),
                                      at: index)
                
            }
        }
        
        return currentSection
    }
    
    private func updateTopRatedSection(topRatedList: MovieListDataType) -> [Section] {
        var currentSection = self.sectionsData.value
        if let index = currentSection.firstIndex(where: { $0.model == .topRated(offset: 0) }),
           let newItems = currentSection[index].elements[safe: 0]?.topRatedItem {
            let newData = newItems + topRatedList.results
            currentSection.remove(at: index)
            if !newData.isEmpty {
                
                currentSection.insert(ArraySection(model: HomeSectionType.topRated(offset: topRatedList.totalPages.orZero),
                                                   elements: [HomeSectionModel.topRated(title: HomeSectionType.topRated(offset: 0).name,
                                                                                       items: newData,
                                                                                       size: HomeSectionSize(type: .topRated))]),
                                      at: index)
                
            }
        }
        
        return currentSection
    }
    
    private func updateUpComingSection(upComingList: MovieListDataType) -> [Section] {
        var currentSection = self.sectionsData.value
        if let index = currentSection.firstIndex(where: { $0.model == .upComing(offset: 0) }),
           let newItems = currentSection[index].elements[safe: 0]?.upComingItem {
            let newData = newItems + upComingList.results
            currentSection.remove(at: index)
            if !newData.isEmpty {
                
                currentSection.insert(ArraySection(model: HomeSectionType.upComing(offset: upComingList.totalPages.orZero),
                                                   elements: [HomeSectionModel.upComing(title: HomeSectionType.upComing(offset: 0).name,
                                                                                       items: newData,
                                                                                       size: HomeSectionSize(type: .upComing))]),
                                      at: index)
                
            }
        }
        
        return currentSection
    }
}

//MARK:- ACTION
extension HomeViewModel {
    private func getTrendingList() -> Observable<TrendingListModel> {
        return apiService.fetchTrending()
            .trackActivity(self.loading)
            .trackError(self.error)
            .catchErrorJustReturn(TrendingListModel())
    }
    
    private func getGenreList() -> Observable<GenreListModel> {
        return apiService.fetchGenres()
            .trackActivity(self.loading)
            .trackError(self.error)
            .catchErrorJustReturn(GenreListModel())
    }
    
    private func getPopularList(offset: Int) -> Observable<MovieListModel> {
        return apiService.fetchPopular(offset: offset)
            .trackActivity(self.loading)
            .trackError(self.error)
            .catchErrorJustReturn(MovieListModel())
    }
    
    private func getTopRatedList(offset: Int) -> Observable<MovieListModel> {
        return apiService.fetchTopRated(offset: offset)
            .trackActivity(self.loading)
            .trackError(self.error)
            .catchErrorJustReturn(MovieListModel())
    }
    
    private func getUpComingList(offset: Int) -> Observable<MovieListModel> {
        return apiService.fetchUpComing(offset: offset)
            .trackActivity(self.loading)
            .trackError(self.error)
            .catchErrorJustReturn(MovieListModel())
    }
}
