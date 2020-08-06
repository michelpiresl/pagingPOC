//
//  Api.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 06/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

final class Api {
    
    static let baseURL: String = "http://newsapi.org/v2"
    
    static let shared = Api()
    
    func searchFor(_ query: String, page: Int = 1, completion: @escaping (HeadlinesResponse) -> Void) {
        guard let url = URL(string: "\(Api.baseURL)/everything?q=\(query)&page=\(page)") else { return }
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        request.httpMethod = "GET"

        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                debugPrint(error)
            } else {
                guard let response = response  as? HTTPURLResponse, let data = data else {
                    print("No response or data.")
                    return }
                if response.statusCode == 200 {
                    if let headlines = self.parseJSON(data, to: HeadlinesResponse.self) {
                        DispatchQueue.main.async {
                            completion(headlines)
                        }
                    }
                } else { print("HTTP Status Code: \(response.statusCode)") }
            }
        }
        dataTask.resume()
    }

    
    func topHeadlines(page: Int = 1, completion: @escaping (HeadlinesResponse) -> Void) {
        guard let url = URL(string: "\(Api.baseURL)/top-headlines?country=us&page=\(page)") else { return }
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        request.httpMethod = "GET"

        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                debugPrint(error)
            } else {
                guard let response = response  as? HTTPURLResponse, let data = data else {
                    print("No response or data.")
                    return }
                if response.statusCode == 200 {
                    if let headlines = self.parseJSON(data, to: HeadlinesResponse.self) {
                        DispatchQueue.main.async {
                            completion(headlines)
                        }
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    private func parseJSON<T: Codable>(_ data: Data, to type: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
}
