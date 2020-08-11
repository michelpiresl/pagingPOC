//
//  HTTPRequest.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 07/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

///A request type to be dispatched on a HTTP service.
protocol HTTPRequest {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPRequestMethod { get }
    var header: [String:String]? { get }
    var parameters: HTTPRequestParameters? { get }
    
}
