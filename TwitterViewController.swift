//
//  TwitterViewController.swift
//  Twitter Navigation Bar
//
//  Created by Alfredo Uzumaki on 8/9/18.
//  Copyright © 2018 Alfredo Uzumaki. All rights reserved.
//

import UIKit

class TwitterViewController: UIViewController, UIScrollViewDelegate {
    
    var headerStopPoint:CGFloat = 84 // navigation bar smallest position height
    var headerBottomPoint:CGFloat = 95 // At this offset the Black label reaches the Header
    var titleBottomDistance:CGFloat = -10 // The distance between the bottom of the Header and the the White title Label
    var extraNavigationBarHeight:CGFloat = 0
    var header = UIView()
    var headerLabel = UILabel()
    var headerImageView = UIImageView()
    var headerBlurImageView = UIImageView()
    var headerLabelYPosition:CGFloat = 35
    
//    override var prefersStatusBarHidden: Bool { // uncomment this for more customizations.
//        return true
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        var headerTransform = CATransform3DIdentity
        if offset < 0 {
            let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation + extraNavigationBarHeight, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            header.layer.transform = headerTransform
        } else {
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-headerStopPoint, -offset) + extraNavigationBarHeight, 0)
            let labelTransform = CATransform3DMakeTranslation(0, max(-titleBottomDistance - 10, headerBottomPoint - offset) + headerLabelYPosition, 0)
            headerLabel.layer.transform = labelTransform
            UIView.animate(withDuration: 0.4) {
                self.headerBlurImageView.alpha = 1 - max(0.0, (offset - self.headerBottomPoint)/self.titleBottomDistance)
            }
        }
        header.layer.transform = headerTransform
    }
    
    func setupTwitterNavigationBar(scrollView:UIScrollView, withCustomHeight optional:CGFloat = 150, image:UIImage, titleLabel:UILabel = UILabel()) {
        setStatusBarBackgroundColor(color: .clear)
        navigationController?.isNavigationBarHidden = true
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        headerLabel = titleLabel.text != nil ? titleLabel : UILabel()
        let navBarHeight = optional != 0 ? optional : getNavBarHeight()
        header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: navBarHeight))
        header.backgroundColor = .black
        self.view.addSubview(header)
        headerLabel.frame = CGRect(x: (view.frame.width / 2) - 100, y: navBarHeight / 2, width: 200, height: 30)
        headerLabel.textAlignment = .center
        self.header.addSubview(headerLabel)
        if #available(iOS 11.0, *) {
            if UIApplication.shared.statusBarFrame.height > CGFloat(20) { // iphone X
                headerStopPoint = 50
                headerBottomPoint = 95
                titleBottomDistance = -20
                extraNavigationBarHeight = -10
                headerLabelYPosition = 20
            }
        }
        headerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: navBarHeight))
        headerImageView.image = image
        headerImageView.contentMode = UIViewContentMode.scaleAspectFill
        header.insertSubview(headerImageView, belowSubview: headerLabel)
        headerBlurImageView = UIImageView(frame: header.bounds)
        var blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
        if #available(iOS 10.0, *) {
            blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.regular))
        }
        blur.frame = headerBlurImageView.bounds
        headerBlurImageView.insertSubview(blur, at: 0)
        headerBlurImageView.contentMode = UIViewContentMode.scaleAspectFill
        headerBlurImageView.alpha = 0.0
        header.insertSubview(headerBlurImageView, belowSubview: headerLabel)
        header.clipsToBounds = true
        headerLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    }
    
    private func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    
    private func getNavBarHeight() -> CGFloat {
        let nav = UINavigationController()
        return nav.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height
    }
}
