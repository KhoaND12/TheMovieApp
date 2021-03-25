//
//  UIScrollView+Extensions.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 22/03/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie

extension Reactive where Base: UIScrollView {
    
    var scrolledToEnd: ControlEvent<Void> {
        let event = Observable
            .zip(contentOffset.skip(1), contentOffset)
            .flatMap { [weak base] current, previous -> Observable<Void> in
                guard let scrollView = base, current.x - previous.x > 0 && current.x > 0 else {
                    return .empty()
                }
                
                let x = current.x + scrollView.contentInset.left
                let visibleWidth = scrollView.frame.width - scrollView.contentInset.left - scrollView.contentInset.right
                let threshold = max(0.0, scrollView.contentSize.width - visibleWidth)
                
                return x > threshold ? .just(()) : .empty()
            }
        .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
        
        return ControlEvent(events: event)
    }
    
}


