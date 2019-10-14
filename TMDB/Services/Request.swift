//
//  Request.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

class Request {
    static let shared: Request = Request()
    private let imageCache: AutoPurgingImageCache = AutoPurgingImageCache(memoryCapacity: 100 * 1024 * 1024,
                                                                          preferredMemoryUsageAfterPurge: 60*1024*1024)
    private let baseURL: String = "https://api.themoviedb.org/3/"
    private let baseImageURL: String = "https://image.tmdb.org/t/p/w370_and_h556_bestv2"
    private init() {}
    func JSON<T: Decodable>(path: String,
                            method: HTTPMethod,
                            parameters: Parameters?,
                            headers: HTTPHeaders?,
                            encoding: ParameterEncoding = JSONEncoding.default,
                            completion: @escaping (_ response: T?,
                                                   _ error: ErrorObject?) -> Void) -> Alamofire.Request {
        return Alamofire.request(baseURL + path,
                                 method: method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: headers)
            .validate()
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let resultData: T = try JSONDecoder().decode(T.self, from: data)
                            completion(resultData, nil)
                        } catch {
                            completion(nil, ErrorObject(code: -2, message: "Error trying to parse server response."))
                        }
                    } else {
                        completion(nil, ErrorObject(code: -3, message: "Server response empty."))
                    }
                case .failure(let error):
                    completion(nil, ErrorObject(code: (error as? AFError)?.responseCode ?? -4,
                                                message: error.localizedDescription))
                }
        }
    }
    func IMAGE(path: String, completion: @escaping (UIImage?) -> Void) -> Alamofire.Request? {
        let fullPath: String = baseImageURL + path
        if let cachedImage = getCachedImage(for: fullPath) {
            completion(cachedImage)
            return nil
        } else {
            return Alamofire.request(fullPath, method: .get).responseImage { (response) in
                if let image = response.result.value {
                    self.cacheImage(image, for: fullPath)
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
    }
    private func cacheImage(_ image: UIImage, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }
    private func getCachedImage(for url: String) -> UIImage? {
        return imageCache.image(withIdentifier: url)
    }
}
