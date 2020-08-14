//
//  DefaultURLRequestBuilder.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 13/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

class DefaultURLRequestBuilder: URLRequestBuilder {
    
    func build(_ request: HTTPRequest) -> URLRequest? {
        //Build URL
        var url = URL(string: request.baseURL)
        url?.appendPathComponent(request.path)
        guard let _url = url else { return nil }
        //Build URLRequest
        var urlRequest = URLRequest(url: _url)
        //Set HTTPMethod
        urlRequest.httpMethod = request.method.name
        //Build Header
        if let header = request.header {
            header.forEach {
                urlRequest.addValue($1, forHTTPHeaderField: $0)
            }
        }
        //Build Parameters either on the URL or Body
        if let parameters = request.parameters {
            buildParameters(parameters, on: &urlRequest)
        }
        return urlRequest
    }
    
    private func buildParameters(_ parameters: HTTPRequestParameters, on urlRequest: inout URLRequest) {
        switch parameters {
        case .urlParameters(let urlParameters):
            urlRequest.url = buildURLParameters(urlParameters, for: urlRequest.url)
        case .bodyParameters(let bodyParameters):
            urlRequest.httpBody = buildBodyParameters(bodyParameters)
        }
    }
    
    private func buildURLParameters(_ parameters: [String:String]?, for url: URL? ) -> URL? {
        if let parameters = parameters,
            let url = url,
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            return urlComponents.url
        } else {
            return url
        }
    }
    
    private func buildBodyParameters(_ parameters: [String:Any]?) -> Data? {
        if let parameters = parameters {
            let json = try? JSONSerialization.data(withJSONObject: parameters)
            return json
        } else {
            return nil
        }
    }
    
}
