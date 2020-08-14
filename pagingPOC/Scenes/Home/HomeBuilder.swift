//
//  HomeBuilder.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 11/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

final class HomeBuilder: SceneBuilder {
    
    private let searchService: SearchForNewsServiceProtocol
    private let downloadImageService: DownloadImageServiceProtocol
    
    init(searchService: SearchForNewsServiceProtocol, downloadImageService: DownloadImageServiceProtocol) {
        self.searchService = searchService
        self.downloadImageService = downloadImageService
    }
    
    func build() -> UIViewController {
        let viewModel = HomeViewModel(searchService: searchService, downloadImageService: downloadImageService)
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
    
}
