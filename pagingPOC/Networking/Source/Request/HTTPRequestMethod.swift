//
//  HTTPRequestMethod.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 10/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

enum HTTPRequestMethod: String {
    
    case get
    case post
    
    var name: String {
        return self.rawValue.uppercased()
    }
    
}
