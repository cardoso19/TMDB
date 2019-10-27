//
//  ImageCache.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 16/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

class ImageCache {

    // MARK: - Variables
    static let shared: ImageCache = ImageCache()
    private let storedCache: NSCache<NSString, UIImage>

    // MARK: - Life Cycle
    private init() {
        storedCache = NSCache<NSString, UIImage>()
    }

    // MARK: - DataStore
    func insert(item: UIImage, key: String) {
        storedCache.setObject(item, forKey: NSString(string: key))
    }

    func receiveItem(key: String) -> UIImage? {
        return storedCache.object(forKey: NSString(string: key))
    }
}
