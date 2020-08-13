///Users/michel/Documents/pagingPOC/pagingPOC/Networking/Services/SearchForNews/SearchForNewsService.swift
//  SearchForNewsService.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 07/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

protocol SearchForNewsServiceProtocol: NetworkService {
    
    func searchFor(_ query: String, page: Int, pageSize: Int, completion: @escaping (Result<NewsList, SearchForNewsError>) -> Void)
    func requestImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

enum SearchForNewsError: Error {
    
    case networkingError
    
}

final class SearchForNewsService: SearchForNewsServiceProtocol {
    
    let dispatcher: NetworkDispatcherProtocol
    private let dateFormatter: ISO8601DateFormatter
    private let imageCache = NSCache<NSString, UIImage>()
    
    init(dispatcher: NetworkDispatcherProtocol, dateFormatter: ISO8601DateFormatter) {
        self.dispatcher = dispatcher
        self.dateFormatter = dateFormatter
    }
    
    func searchFor(_ query: String,
                   page: Int = 1,
                   pageSize: Int = 20,
                   completion: @escaping (Result<NewsList, SearchForNewsError>) -> Void) {
        let request = SearchForNewsRequest(query: query,
                                           page: page,
                                           pageSize: pageSize)
        dispatcher.execute(request, to: SearchForNewsResponse.self) { [weak self] (result) in
            switch result {
            case .success(let responseData):
                if let response = responseData {
                    let numberOfNews = min(response.totalResults ?? 0, 100)
                    var newsList = NewsList(numberOfNews: numberOfNews)
                    if let articles = response.articles {
                        articles.forEach { article in
                            let news = News(time: self?.dateFormatter.date(from: article.publishedAt ?? "") ?? Date(),
                                            source: article.source?.name ?? "",
                                            title: article.title ?? "",
                                            description: article.description ?? "",
                                            urlString: article.url ?? "",
                                            imageUrlString: article.urlToImage)
                            newsList.news.append(news)
                        }
                    }
                    completion(.success(newsList))
                } else {
                    completion(.failure(.networkingError))
                }
            case .failure:
                completion(.failure(.networkingError))
            }
        }
    }
    
    func requestImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(image)
        } else {
            dispatcher.execute(url) { [weak self] (result) in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.imageCache.setObject(image ?? UIImage(), forKey: url.absoluteString as NSString)
                    completion(image)
                case .failure:
                    completion(nil)
                }
            }
        }
    }
    
}
