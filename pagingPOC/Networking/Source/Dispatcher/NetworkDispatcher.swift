//
//  DefaultNetworkDispatcher.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 07/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
    
    var requestBuilder: URLRequestBuilder { get }
    var session: URLSession { get }
    
    ///Execute a data task with a HTTPRequest, returning a decoded object on completion.
    func execute<T: Codable>(_ request: HTTPRequest, to type: T.Type, completion: @escaping (Result<T?, DispatchError>) -> Void)
    
    ///Execute a data task with a URL, returning a Data object.
    func execute(_ url: URL, completion: @escaping (Result<Data, DispatchError>) -> Void)
    
}
