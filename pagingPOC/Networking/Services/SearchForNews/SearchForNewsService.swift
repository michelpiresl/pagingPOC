///Users/michel/Documents/pagingPOC/pagingPOC/Networking/Services/SearchForNews/SearchForNewsService.swift
//  SearchForNewsService.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 07/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

protocol SearchForNewsServiceProtocol: NetworkService {
    
    var dateFormatter: ISO8601DateFormatter { get }
    
    func searchFor(_ query: String, page: Int, pageSize: Int, completion: @escaping (Result<NewsList, SearchForNewsError>) -> Void)

}

enum SearchForNewsError: Error {
    
    case networkingError
    
}

final class SearchForNewsService: SearchForNewsServiceProtocol {
    
    @Inject var dispatcher: NetworkDispatcher
    @Inject var dateFormatter: ISO8601DateFormatter
        
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
    
}
