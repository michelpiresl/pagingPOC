//
//  HTTPRequest.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 07/08/20.
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

enum HTTPRequestParameters {
    
    case url([String:String]?)
    case body([String:Any]?)
    
}

///A request type to be dispatched on a HTTP service.
protocol HTTPRequest {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPRequestMethod { get }
    var header: [String:String]? { get }
    var parameters: HTTPRequestParameters? { get }
    
}
