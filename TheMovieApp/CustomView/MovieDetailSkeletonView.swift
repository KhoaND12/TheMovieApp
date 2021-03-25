//
//  MovieDetailSkeletonView.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 25/03/2021.
//

import UIKit

class MovieDetailSkeletonView: UIView {

    var containterView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        guard let contentView = R.nib.movieDetailSkeletonView(owner: self) else { return }
        containterView = contentView
        constrainToEdges(contentView)
    }
    
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        containterView.skeletionLoading()
    }


}
