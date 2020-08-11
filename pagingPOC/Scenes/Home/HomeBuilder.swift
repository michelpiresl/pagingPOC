//
//  HomeBuilder.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 11/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

final class HomeBuilder: SceneBuilder {
    
    static func viewController() -> UIViewController {
        let service = SearchForNewsService()
        let viewModel = HomeViewModel(service: service)
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
    
}
