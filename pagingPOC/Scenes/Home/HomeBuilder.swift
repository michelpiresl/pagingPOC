//
//  HomeBuilder.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 11/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

final class HomeBuilder: SceneBuilder { //Não deu para usar o protocolo Builder pois cada Builder tá um argumento diferente para seu build()

    private let service: SearchForNewsServiceProtocol
    
    init(service: SearchForNewsServiceProtocol) {
        self.service = service
    }
    
    func build() -> UIViewController {
        let viewModel = HomeViewModel(service: service)
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
    
}
