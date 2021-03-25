//
//  MovieHomeViewController.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import UIKit
import RxSwift
import DifferenceKit
import Action
import RxCocoa
import Resolver
import SwiftyUserDefaults
import SwiftEntryKit
import RxAppState

class HomeViewController: BaseViewController, BindableType {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            registerCells()
            ///
            collectionView.dataSource = self
            collectionView.delegate = self
            
        }
    }
    
    lazy var refreshHandler: RefreshHandler = {
        return RefreshHandler(view: collectionView)
    }()
    
    internal var viewModel: HomeViewModelType!
    internal var data = [HomeViewModel.Section]()
    private var dataInput: [HomeViewModel.Section] {
        get { return data }
        set {
            self.data = newValue
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///
        setupCommon()
        ///
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ///
        self.navigationController?.addShadow()
    }
    
    private func setupNavigationBar() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 27))
        imageView.image = R.image.iconLogo()
        self.navigationItem.titleView = imageView
        ///
        self.addNavigationBarButton(imageName: "icon.search", direction:.right)
        self.addNavigationBarButton(imageName: "icon.user", direction:.left)
    }
    
    func bindViewModel() {
        let input = HomeInput(pullToRefresh: refreshHandler.refresh.asDriver(onErrorJustReturn: ()),
                              willAppear: rx.viewWillAppear)
        
        viewModel.transform(input: input)
        
        viewModel.output?.reloadContent.skip(1).drive(onNext: { [weak self] (sections) in
            guard let `self` = self, !sections.isEmpty else { return }
            self.dataInput = sections
        }).disposed(by: rx.disposeBag)

        // close PullToRefresh
        viewModel.output?.loading
            .skip(3)
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .delay(.milliseconds(500))
            .drive(refreshHandler.rx.endRefresh)
            .disposed(by: rx.disposeBag)

        viewModel.error.drive(self.error).disposed(by: rx.disposeBag)
        
    }
    
    private func setupCommon() {
        ///
        collectionView.contentInsetAdjustmentBehavior = .never
    }

    private func registerCells() {
        collectionView.register(R.nib.trendingViewSectionCell)
        collectionView.register(R.nib.categoryViewSectionCell)
        collectionView.register(UINib(nibName: "MovieViewSectionCell", bundle: nil), forCellWithReuseIdentifier: Constants.reuseIdentifier.popularCell)
        collectionView.register(UINib(nibName: "MovieViewSectionCell", bundle: nil), forCellWithReuseIdentifier: Constants.reuseIdentifier.topRatedCell)
        collectionView.register(UINib(nibName: "MovieViewSectionCell", bundle: nil), forCellWithReuseIdentifier: Constants.reuseIdentifier.upComingCell)
    }
    
    //MARK: -Action
    @objc func searchButtonTapped() {
        
    }
}
