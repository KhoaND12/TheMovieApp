//
//  UIViewController+Extensions.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 22/03/2021.
//

import UIKit

extension UIViewController {
    public func addNavigationBarButton(imageName:String,direction:direction){
        var image = UIImage(named: imageName)
        image = image?.withRenderingMode(.alwaysOriginal)
        switch direction {
        case .left:
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: nil, action: #selector(goBack))
        case .right:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: nil, action: #selector(goBack))
        }
    }

    @objc public func goBack() {
        self.navigationController?.popViewController(animated: true)
    }

    public enum direction {
        case right
        case left
    }
    
    func showAlert(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.alertConfirm(), style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}

