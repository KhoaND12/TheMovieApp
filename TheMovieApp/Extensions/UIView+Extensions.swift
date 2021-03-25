//
//  UIView+Extensions.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 18/03/2021.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

extension UIView {
    //MARK: -  Layout
    private var bottomLineViewTag: Int {
           return 1101
    }
    
    private var topLineViewTag: Int {
        return 1102
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else { layer.borderColor = nil; return }
            layer.borderColor = color.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
    @IBInspectable
    var topShadowLine: Bool {
        get { return layer.shadowOpacity > 0 ? true : false }
        set {
            layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.width, height: 2)).cgPath
            layer.shadowRadius = 2
            layer.shadowOffset = .zero
            layer.shadowOpacity = newValue ? 0.4 : 0
            clipsToBounds = false
            layer.masksToBounds = false
            layer.rasterizationScale = UIScreen.main.scale
            self.layer.shouldRasterize = true
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else { layer.shadowColor = nil; return }
            layer.shadowColor = color.cgColor
        }
    }
    
    func constrainToEdges(_ childView: UIView, offset rect: UIEdgeInsets = .zero) {
        self.addSubview(childView)
        childView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(rect)
        }
    }
    
    //MARK:- CUSTOM BOTTOM LINE FOR A VIEW
    @IBInspectable
    var hasBottomLine: Bool {
        get { return self.viewWithTag(bottomLineViewTag) != nil }
        
        set {
            if(newValue) {
                DispatchQueue.main.async {
                    self.addBottomLine()
                }
            } else {
                if let lineView = self.viewWithTag(bottomLineViewTag) {
                    DispatchQueue.main.async {
                        lineView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    @IBInspectable
    var hasTopLine: Bool {
        get { return self.viewWithTag(bottomLineViewTag) != nil }
        
        set {
            if(newValue) {
                DispatchQueue.main.async {
                    self.addTopLine()
                }
            } else {
                if let lineView = self.viewWithTag(topLineViewTag) {
                    DispatchQueue.main.async {
                        lineView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    private func addBottomLine() {
        
        let lineView = UIView(frame: .zero)
        lineView.tag = bottomLineViewTag
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = UIColor.gray
        self.addSubview(lineView)
        self.bringSubviewToFront(lineView)
        
        lineView.snp.makeConstraints { (view) in
            view.left.bottom.right.equalTo(self)
            view.height.equalTo(1)
        }
    }
    
    private func addTopLine() {
        
          let lineView = UIView(frame: .zero)
          lineView.tag = topLineViewTag
          lineView.translatesAutoresizingMaskIntoConstraints = false
          lineView.backgroundColor = UIColor.gray
          self.addSubview(lineView)
          self.bringSubviewToFront(lineView)
          
          lineView.snp.makeConstraints { (view) in
              view.left.top.right.equalTo(self)
              view.height.equalTo(1)
          }
    }
    
    var width: CGFloat {
        return self.bounds.width
    }
    
    var height: CGFloat {
        return self.bounds.height
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
}

//MARK:- FUNCTION
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        layer.mask = nil
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addShadow(color: UIColor = .lightGray, opacity: Float = 1, radius: CGFloat = 6, offSet: CGSize) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
    }
    
    func addGradient(fromColor: UIColor = UIColor(red: 100, green: 172, blue: 196), toColor: UIColor = UIColor(red: 27, green: 47, blue: 144)) {
        let gradient = CAGradientLayer()

        gradient.frame = self.bounds
        gradient.colors = [fromColor.cgColor, toColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func skeletionLoading() {
        let light = UIColor.black.withAlphaComponent(1.0).cgColor
        let alpha = UIColor.clear.withAlphaComponent(1.0).cgColor
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0,
                                y: 0,
                                width: UIScreen.main.bounds.width,
                                height: 2 * UIScreen.main.bounds.height)
        gradient.colors = [light, alpha, light, alpha, light, alpha]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0,y: 0.5)
        gradient.locations = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = [0.5]
        opacityAnimation.toValue = [1.0]
        
        let locationAnimation = CABasicAnimation(keyPath: "locations")
        locationAnimation.fromValue = [0.0, 0.1, 0.2]
        locationAnimation.toValue = [0.8, 0.9, 1.0]
        
        let group = CAAnimationGroup()
        
        group.duration = 0.75
        group.repeatCount = HUGE
        group.autoreverses = true
        group.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        group.animations = [opacityAnimation, locationAnimation]
        
        subviews.forEach { (view) in
            view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
            view.layer.mask = gradient
            view.layer.add(group, forKey: "flash")
        }
    }
}

private var loadingViewKey: UInt8 = 0
extension UIView {
    var loadingView: UIView {
        get { return associatedObject(base: self, key: &loadingViewKey) { return UIView() } }
        set { associateObject(base: self, key: &loadingViewKey, value: newValue) }
    }
}

func associatedObject<ValueType: AnyObject>(
        base: AnyObject,
        key: UnsafePointer<UInt8>,
        initialiser: () -> ValueType)
        -> ValueType {
    if let associated = objc_getAssociatedObject(base, key)
        as? ValueType { return associated }
    let associated = initialiser()
    objc_setAssociatedObject(base, key, associated,
                             .OBJC_ASSOCIATION_RETAIN)
    return associated
}
func associateObject<ValueType: AnyObject>(
        base: AnyObject,
        key: UnsafePointer<UInt8>,
        value: ValueType) {
    objc_setAssociatedObject(base, key, value,
                             .OBJC_ASSOCIATION_RETAIN)
}

extension Reactive where Base: UIView {
    //MARK:- LOADINGVIEW FOR SCROLLVIEW
    var trackLoadingWithLottieAnim: Binder<LoadingWithLottie> {
        return Binder<LoadingWithLottie>(self.base) { (view, loadingType) in
            if (loadingType.isLoading) {
                self.base.loadingView = loadingType.type.animationView
                view.parentViewController?.view.constrainToEdges(self.base.loadingView)
            } else {
                UIView.animate(withDuration: 1, animations: {
                    self.base.loadingView.alpha = 0.0
                }) { _ in
                    self.base.loadingView.alpha = 1.0
                    self.base.loadingView.snp.removeConstraints()
                    self.base.loadingView.removeFromSuperview()
                }
            }
        }
    }
}

