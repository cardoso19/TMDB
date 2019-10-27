//
//  MDTLoading.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

class MDTLoading {
    /// Show the default loader.
    public static func showDefaultLoader() {
        var flagAdded = false
        if let subviews = UIApplication.shared.keyWindow?.subviews {
            for view in subviews where view.restorationIdentifier == "loadingView" {
                flagAdded = true
            }
        }
        if !flagAdded {
            let overlayInvisible = UIView()
            overlayInvisible.frame = UIScreen.main.bounds
            overlayInvisible.center = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height / 2.0)
            overlayInvisible.backgroundColor = UIColor.black.withAlphaComponent(0.25)
            let overlayView = UIView()
            overlayView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            overlayView.center = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height / 2.0 )
            overlayView.backgroundColor = .white
            overlayView.layer.cornerRadius = 6
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.style = .gray
            activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2.0, y: overlayView.bounds.height / 2.0)
            activityIndicator.startAnimating()
            activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            overlayView.addSubview(activityIndicator)
            overlayView.alpha = 0
            overlayInvisible.restorationIdentifier = "loadingView"
            overlayInvisible.addSubview(overlayView)
            UIApplication.shared.keyWindow!.addSubview(overlayInvisible)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                overlayView.alpha = 1.0
            }, completion: nil)
        }
    }
    /// Hide the default loader.
    public static func hideDefaultLoading() {
        if let subviews = UIApplication.shared.keyWindow?.subviews {
            for view in subviews where view.restorationIdentifier == "loadingView" {
                view.removeFromSuperview()
            }
        }
    }

}
