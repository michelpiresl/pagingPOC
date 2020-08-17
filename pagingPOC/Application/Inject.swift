//
//  Inject.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 14/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

@propertyWrapper
struct Inject<T> {
    
    private var dependency: T
            
    init() {
//        if T.self == NetworkDispatcher.self {
//            dependency = DefaultNetworkDispatcher() as! T
//
//        } else if T.self == URLRequestBuilder.self {
//            dependency = DefaultURLRequestBuilder() as! T
//
//        } else if T.self == URLSession.self {
//            dependency = URLSession.shared as! T
//
//        } else if T.self == SearchForNewsServiceProtocol.self {
//            dependency = SearchForNewsService() as! T
//
//        } else if T.self == DownloadImageServiceProtocol.self {
//            dependency = DownloadImageService() as! T
//
//        } else if T.self == NSCache<NSString, UIImage>.self {
//            dependency = NSCache<NSString, UIImage>() as! T
//
//        } else if T.self == ISO8601DateFormatter.self {
//            dependency = ISO8601DateFormatter() as! T
//
//        } else {
//            fatalError("Type \(T.self) is not registered at dependency injector")
//        }
        
        switch T.self {
            
        case is NetworkDispatcher.Protocol:
            dependency = DefaultNetworkDispatcher() as! T
            
        case is URLRequestBuilder.Protocol:
            dependency = DefaultURLRequestBuilder() as! T
            
        case is URLSession.Type:
            dependency = URLSession.shared as! T
            
        case is SearchForNewsServiceProtocol.Protocol:
            dependency = SearchForNewsService() as! T
        
        case is DownloadImageServiceProtocol.Protocol:
            dependency = DownloadImageService() as! T
            
        case is NSCache<NSString, UIImage>.Type:
            dependency = NSCache<NSString, UIImage>() as! T
            
        case is ISO8601DateFormatter.Type:
            dependency = ISO8601DateFormatter() as! T
            
        default:
            fatalError("Type \(T.Type.self) is not registered at dependency injector")
        }
    }
    
    var wrappedValue: T {
        get { return dependency }
        set { dependency = newValue }
    }
    
}
