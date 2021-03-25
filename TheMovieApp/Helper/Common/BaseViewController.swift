//
//  BaseViewController.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 17/03/2021.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import Resolver

class BaseViewController: UIViewController {
    let error = BehaviorRelay<Error?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///
        bindError()
    }
    
    deinit {
        logDebug("\(type(of: self)): Deinited")
    }
}

extension BaseViewController {
    fileprivate func bindError() {
        self.error.asDriver()
            .throttle(.seconds(3))
            .drive(onNext: { [weak self] (error) in
                guard let `self` = self, let error = error else { return }
                ///
                self.showAlert(message: error.localizedDescription)
            })
            .disposed(by: rx.disposeBag)
    }
}

