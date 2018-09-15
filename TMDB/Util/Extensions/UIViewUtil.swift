//
//  UIViewUtil.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

extension UIView {
    /// Add shadow to the view.
    /// - Parameters:
    ///   - scale: indicate if the layer will rasterize by the content.
    ///   - path: path that the shadow will follow.
    ///   - shadowColor: color that will be added on the shadow.
    func dropShadow(scale: Bool = true, path: CGPath? = nil, shadowColor: UIColor = .black, opacity: Float = 0.2) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
        if let path = path {
            layer.shadowPath = path
        }
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
