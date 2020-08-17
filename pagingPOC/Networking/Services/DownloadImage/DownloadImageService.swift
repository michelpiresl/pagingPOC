//
//  DownloadImageService.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 14/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

protocol DownloadImageServiceProtocol: NetworkService {
    
    var imageCache: NSCache<NSString, UIImage> { get }
    
    func requestImage(from url: URL, completion: @escaping (UIImage?) -> Void)

}

class DownloadImageService: DownloadImageServiceProtocol {
    
    @Inject var dispatcher: NetworkDispatcher
    @Inject var imageCache: NSCache<NSString, UIImage>
    
    func requestImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(image)
        } else {
            dispatcher.execute(url) { [weak self] (result) in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.imageCache.setObject(image ?? UIImage(), forKey: url.absoluteString as NSString)
                    completion(image)
                case .failure:
                    completion(nil)
                }
            }
        }
    }
    
}
