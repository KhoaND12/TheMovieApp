//
//  MovieDetailViewController.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import UIKit
import XCoordinator
import DifferenceKit
import RxSwift
import RxCocoa

class MovieDetailViewController: BaseViewController, BindableType {
    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            /// register cell & header
            registerNib()
            /// setup table
            tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableView.automaticDimension
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorInset = UIEdgeInsets.zero
        }
    }
    
    @IBOutlet weak var backButton: UIButton!
    
    //MARK:- SUPPORT VARIABLES
    internal var viewModel: MovieDetailViewModelType!
    internal var data = [MovieDetailViewModel.Section]()
    private var dataInput: [MovieDetailViewModel.Section] {
        get { return data }
        set {
            let changeset = StagedChangeset(source: data, target: newValue)
            tableView.reload(using: changeset, with: .fade)  { data in
                self.data = data
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ///
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func registerNib() {
        tableView.register(R.nib.movieInfoViewCell)
        tableView.register(R.nib.movieRateViewCell)
        tableView.register(R.nib.movieActorSectionCell)
        tableView.register(R.nib.movieVideoSectionCell)
        tableView.register(R.nib.movieReviewViewCell)
        tableView.register(R.nib.movieRecommendSectionCell)
        tableView.register(UINib(nibName: "MovieHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: MovieHeaderView.reuseIdentifier)
    }
    
    func bindViewModel() {
        let input = MovieDetailInput(willAppear: rx.viewWillAppear)
        
        viewModel.transform(input: input)
        
        viewModel.output?.sectionDatas
            .drive(onNext: { [weak self] (result) in
                guard let `self` = self else { return }
                self.dataInput = result
            }).disposed(by: rx.disposeBag)
        
        //show loading animation
        viewModel.output?.loading
            .skip(1)
            .distinctUntilChanged()
            .take(2)
            .asDriver(onErrorJustReturn: false)
            .map { LoadingWithLottie(.detail, $0) }
            .drive(tableView.rx.trackLoadingWithLottieAnim)
            .disposed(by: rx.disposeBag)
        
        viewModel.error.drive(self.error).disposed(by: rx.disposeBag)
        /// bind action
        self.bindAction()
    }
    
    private func bindAction() {
        guard let backActionUnwrap = viewModel.output?.backActionTrigger else { return }
        
        backButton.rx.tap
            .bind(to: backActionUnwrap)
            .disposed(by: rx.disposeBag)
    }
}
