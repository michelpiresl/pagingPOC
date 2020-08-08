//
//  SearchForNewsRequest.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 07/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

struct SearchForNewsRequest: HTTPRequest {
    
    var baseURL: String {
        return "http://newsapi.org/v2"
    }
    
    var path: String {
        return "everything"
    }
    
    var method: HTTPRequestMethod {
        return .get
    }
    
    var header: [String : String]? {
        return [
            "X-Api-Key" : apiKey
        ]
    }
    
    var parameters: HTTPRequestParameters? {
        return .url([
            "q" : query,
            "page" : page
        ])
    }
    
    let query: String
    let page: String
    
    init (
        query: String,
        page: Int = 1
    ) {
        self.query = query
        self.page = String(page)
    }
    
}
