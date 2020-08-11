//
//  HTTPRequestParameters.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 10/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

enum HTTPRequestParameters {
    
    case urlParameters([String:String]?)
    case bodyParameters([String:Any]?)
    
}
