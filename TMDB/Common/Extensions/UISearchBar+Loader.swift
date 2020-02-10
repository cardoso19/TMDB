//
//  UISearchBar+Loader.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 28/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

extension UISearchBar {

    private var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            return subviews.first?.subviews.compactMap { $0 as? UITextField }.first
        }
    }

    private var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
    }

    var isLoading: Bool {
        get {
            return activityIndicator != nil
        }
        set {
            guard newValue else {
                activityIndicator?.removeFromSuperview()
                return
            }
            guard activityIndicator == nil else { return }
            let center = textField?.leftView?.center ?? CGPoint.zero
            textField?.leftView?.addSubview(createActivityIndicator(center: center))
        }
    }

    private func createActivityIndicator(center: CGPoint) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        activityIndicator.backgroundColor = .white
        activityIndicator.startAnimating()
        activityIndicator.center = center
        return activityIndicator
    }
}
