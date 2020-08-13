//
//  NetworkService.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 12/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

protocol NetworkService {
    
    var dispatcher: NetworkDispatcherProtocol { get }
    
}
