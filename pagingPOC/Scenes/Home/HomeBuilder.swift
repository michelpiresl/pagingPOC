//
//  HomeBuilder.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 11/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

final class HomeBuilder: SceneBuilder {
    
    @Inject private var searchService: SearchForNewsServiceProtocol
    @Inject private var downloadImageService: DownloadImageServiceProtocol
    
    func build() -> UIViewController {
        let viewModel = HomeViewModel(searchService: searchService, downloadImageService: downloadImageService)
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
    
}
