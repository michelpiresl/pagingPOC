//
//  SearchForNewsService.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 07/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

enum SearchForNewsError: Error {
    
    case networkingError
    
}

final class SearchForNewsService {
    
    private let dispatcher = Dispatcher()
    
    func searchFor(_ query: String, page: Int = 1, completion: @escaping (Result<NewsList, SearchForNewsError>) -> Void) {
        let request = SearchForNewsRequest(query: query,
                                           page: page)
        dispatcher.execute(request, to: SearchForNewsResponse.self) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let responseData):
                    if let response = responseData {
                        let numberOfNews = min(response.totalResults ?? 0, 100)
                        var newsList = NewsList(numberOfNews: numberOfNews)
                        if let articles = response.articles {
                            articles.forEach { article in
                                let news = News(time: article.publishedAt ?? "",
                                                source: article.source?.name ?? "",
                                                title: article.title ?? "",
                                                description: article.description ?? "")
                                newsList.news.append(news)
                            }
                        }
                        completion(.success(newsList))
                    } else {
                        completion(.failure(.networkingError))
                    }
                case .failure(_):
                    completion(.failure(.networkingError))
                }
            }
        }
    }
    
}
