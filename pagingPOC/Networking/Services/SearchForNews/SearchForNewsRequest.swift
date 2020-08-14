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
        return Enviroment.newsApiBaseURL
    }
    
    var path: String {
        return "everything"
    }
    
    var method: HTTPRequestMethod {
        return .get
    }
    
    var header: [String : String]? {
        return [
            "X-Api-Key" : Enviroment.newsApiKey
        ]
    }
    
    var parameters: HTTPRequestParameters? {
        return .urlParameters([
            "q" : query,
            "page" : page,
            "pageSize": pageSize
        ])
    }
    
    let query: String
    let page: String
    let pageSize: String
    
    init (
        query: String,
        page: Int = 1,
        pageSize: Int = 20
    ) {
        self.query = query
        self.page = String(page)
        self.pageSize = String(pageSize)
    }
    
}
