//
//  RefreshHandler.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 19/03/2021.
//

import RxRelay
import RxSwift
import RxCocoa

class RefreshHandler: NSObject {
    let refresh = PublishSubject<Void>()
    private let refreshControl = UIRefreshControl()
    private weak var scrollView: UIScrollView?
    
    init(view: UIScrollView) {
        super.init()
        scrollView = view
        scrollView?.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshControlDidRefresh(_: )), for: .valueChanged)
    }
    
    // MARK: - Action
    @objc func refreshControlDidRefresh(_ control: UIRefreshControl) {
        refresh.onNext(())
    }
    
    func endRefresh() {
        refreshControl.endRefreshing()
    }
}

extension Reactive where Base: RefreshHandler {
    var endRefresh: Binder<Bool> {
        return Binder<Bool>(self.base) { (refreshHandler, isLoading) in
            if !isLoading { refreshHandler.endRefresh() }
        }
    }
}

