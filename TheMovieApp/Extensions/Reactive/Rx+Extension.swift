//
//  Rx+Extension.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 25/03/2021.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

extension Reactive where Base: UILabel {
    public func numberOfline() -> Binder<Int> {
        return Binder(self.base) { label, count -> Void in
            label.numberOfLines = count
            label.setNeedsLayout()
        }
    }
}

extension Reactive where Base: UIStackView {
    var genresTitles: Binder<[GenreDataType]> {
        return Binder(self.base) { stackView, genres -> Void in
            genres.prefix(2).forEach {
                let label = UILabel(frame: .zero)
                label.text = "\($0.name.orStringEmpty)"
                label.backgroundColor = R.color.colorBlue007AD9()
                label.textColor = UIColor.white
                label.font = UIFont(name: "Helvetica", size: 12)
                label.textAlignment = .center
                let sizeForWidth = UILabel.measure(text: $0.name.orStringEmpty, font: label.font).width
                label.snp.makeConstraints { (make) in
                    make.width.equalTo(sizeForWidth + 15)
                }
                label.cornerRadius = 10
                label.clipsToBounds = true
                stackView.addArrangedSubview(label)
            }
        }
    }
}
