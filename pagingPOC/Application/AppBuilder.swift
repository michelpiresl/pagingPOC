//
//  AppBuilder.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 13/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

final class AppBuilder: SceneBuilder {
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }()
    
    func build() -> UIViewController {
        navigationController.setViewControllers([IntroBuilder().build()], animated: false)
        return navigationController
    }
    
}
