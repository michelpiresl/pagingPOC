//
//  NetworkDispatcher.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 07/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

protocol NetworkDispatcherProtocol {
    
    ///Execute a data task with a HTTPRequest, returning a decoded object on completion.
    func execute<T: Codable>(_ request: HTTPRequest, to type: T.Type, completion: @escaping (Result<T?, DispatchError>) -> Void)
    
    ///Execute a data task with a URL, returning a Data object.
    func execute(_ url: URL, completion: @escaping (Result<Data, DispatchError>) -> Void)
    
}

final class NetworkDispatcher: NetworkDispatcherProtocol {
    
    func execute<T: Codable>(_ request: HTTPRequest,
                             to type: T.Type,
                             completion: @escaping (Result<T?, DispatchError>) -> Void) {
        guard let urlRequest = buildRequest(request) else {
            completion(.failure(.buildRequestError))
            return
        }
        #if DEBUG
        print("[-------------------- SERVICE REQUEST --------------------]")
        if let urlString = urlRequest.url?.absoluteString {
            debugPrint("URL: \(urlString)")
        } else {
            debugPrint("URL: Nil")
        }
        if let header = urlRequest.allHTTPHeaderFields {
            debugPrint("HEADER: \(header)")
        } else {
            debugPrint("HEADER: Nil")
        }
        if let bodyData = urlRequest.httpBody, let body = String(data: bodyData, encoding: .utf8) {
            debugPrint("BODY: \(body)")
        } else {
            debugPrint("BODY: Nil")
        }
        #endif
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                #if DEBUG
                print("[-------------------- ERROR --------------------]")
                debugPrint(error)
                #endif
                completion(.failure(.requestError(error)))
            } else {
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.unknownResponse))
                    return
                }
                #if DEBUG
                print("[-------------------- SERVICE RESPONSE --------------------]")
                debugPrint("\(response.statusCode) - URL: \(response.url?.absoluteString ?? "")")
                if let dataReceived = data, let dataString = String(data: dataReceived, encoding: .utf8) {
                    debugPrint(dataString)
                }
                #endif
                if 200...299 ~= response.statusCode {
                    guard let data = data else {
                        completion(.success(nil))
                        return
                    }
                    if let resultData: T? = self.parseJSONData(data) {
                        completion(.success(resultData))
                    } else {
                        completion(.failure(.parseError))
                    }
                } else {
                    completion(.failure(.networkingError(response.statusCode))) // TODO: Devolver erro contendo o data (como parsear o JSON?)
                }
            }
        }
        dataTask.resume()
    }
    
    func execute(_ url: URL,
                 completion: @escaping (Result<Data, DispatchError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.requestError(error)))
            } else {
                guard let _ = response, let data = data else {
                    completion(.failure(.unknownResponse))
                    return
                }
                completion(.success(data))
            }
        }
        dataTask.resume()
    }
    
    private func buildRequest(_ request: HTTPRequest) -> URLRequest? {
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
    
    private func parseJSONData<T: Codable>(_ data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            return nil
        }
    }
    
}
