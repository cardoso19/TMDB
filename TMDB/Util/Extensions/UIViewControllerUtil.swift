//
//  UIViewControllerUtil.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

private var kAssociationKeyIsLayoutDefined: UInt8 = 0
extension UIViewController {
    /// Flag that define if the style was applied.
    var isLayoutDefined: Bool {
        get { return objc_getAssociatedObject(self, &kAssociationKeyIsLayoutDefined) as? Bool ?? false }
        set(newValue) { objc_setAssociatedObject(self,
                                                 &kAssociationKeyIsLayoutDefined,
                                                 newValue,
                                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
}
