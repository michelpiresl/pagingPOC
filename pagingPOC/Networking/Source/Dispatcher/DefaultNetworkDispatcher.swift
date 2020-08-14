//
//  DefaultNetworkDispatcher.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 13/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

class DefaultNetworkDispatcher: NetworkDispatcher {
    
    var requestBuilder: URLRequestBuilder
    let session: URLSession
    
    init(with requestBuilder: URLRequestBuilder, for session: URLSession) {
        self.requestBuilder = requestBuilder
        self.session = session
    }
    
    func execute<T: Codable>(_ request: HTTPRequest,
                             to type: T.Type,
                             completion: @escaping (Result<T?, DispatchError>) -> Void) {
        guard let urlRequest = requestBuilder.build(request) else {
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
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
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
                    if let resultData: T? = self.decodeJSON(data) {
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
        #if DEBUG
        print("[-------------------- SERVICE REQUEST --------------------]")
        debugPrint("URL: \(url.absoluteString)")
        #endif
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                #if DEBUG
                print("[-------------------- ERROR --------------------]")
                debugPrint(error)
                #endif
                completion(.failure(.requestError(error)))
            } else {
                guard let _ = response, let data = data else {
                    completion(.failure(.unknownResponse))
                    return
                }
                #if DEBUG
                print("[-------------------- SERVICE RESPONSE --------------------]")
                debugPrint("URL: \(url.absoluteString)")
                debugPrint("Data: \(data)")
                #endif
                completion(.success(data))
            }
        }
        dataTask.resume()
    }
    
    private func decodeJSON<T: Codable>(_ data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            return nil
        }
    }
    
}

