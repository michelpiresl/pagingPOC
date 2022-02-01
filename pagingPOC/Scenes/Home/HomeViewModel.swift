//
//  HomeViewModel.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 11/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

protocol HomePresenter: AnyObject {
    
    func presentIdle()
    func presentErrorAlert(_ message: String)
    
}

final class HomeViewModel {
    
    // MARK: - Service
    private let searchService: SearchForNewsServiceProtocol
    private let downloadImageService: DownloadImageServiceProtocol
    
    // MARK: - Presenter
    weak var presenter: HomePresenter?
    
    // MARK: - Init
    init(searchService: SearchForNewsServiceProtocol, downloadImageService: DownloadImageServiceProtocol) {
        self.searchService = searchService
        self.downloadImageService = downloadImageService
    }
    
    // MARK: - Models
    private var news: [News] = []
    private var numberOfNews: Int = 0
    private var pageSize: Int = 10
    private var page: Int = 1
    private var query: String = "apple"
    
    private var isSearching: Bool = false
    
    // MARK: - Exposed Info
    func getNews(at index: Int) -> News {
        return news[index]
    }
    
    func serviceForCell() -> DownloadImageServiceProtocol {
        return downloadImageService
    }
    
    func newsCount() -> Int {
        return news.count
    }
    
    func newsTotal() -> Int {
        return numberOfNews
    }
    
    // MARK: - Service Requests
    func requestNews() {
        isSearching = true
        searchService.searchFor(query, page: page, pageSize: pageSize) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let newsList):
                self.numberOfNews = newsList.numberOfNews
                self.news += newsList.news
                self.presenter?.presentIdle()
            case .failure:
                if self.news.count == 0 {
                    self.presenter?.presentErrorAlert("Unable to load news")
                }
            }
            self.isSearching = false
        }
    }
    
    // MARK: - Methods
    func requestMoreNews() {
        if numberOfNews > news.count, !isSearching {
            page += 1
            requestNews()
        }
    }

}
