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
    private let service: SearchForNewsServiceProtocol
    weak var presenter: HomePresenter?
    
    // MARK: - Init
    init(service: SearchForNewsServiceProtocol) {
        self.service = service
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
    
    func serviceForCell() -> SearchForNewsServiceProtocol {
        return service
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
        service.searchFor(query, page: page, pageSize: pageSize) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let newsList):
                self.numberOfNews = newsList.numberOfNews
                self.news += newsList.news
                self.presenter?.presentIdle()
            case .failure:
                if self.news.count == 0 {
                    self.presenter?.presentErrorAlert("Não foi possível carregar notícias")
                }
            }
            self.isSearching = false
        }
    }
    
    // MARK: - Methods
    func requestMoreNews() {
        if numberOfNews > news.count, !isSearching { // Se tem mais notícias para exibir
            page += 1
            requestNews()
        }
    }
    
    //    ///Set an image for cell at given position by checking model for image. If model doesnt have an image, it is requested using imageURL.
    //    private func setImageForCell(at indexPath: IndexPath) {
    //        var news = self.news[indexPath.row]
    //        if let cellImage = news.image {
    //            homeView.setImage(cellImage, forCellAt: indexPath)
    //        } else {
    //            guard let url = URL(string: news.imageUrlString ?? "") else { return }
    //            service.requestImage(from: url) { [weak self] (resultImage) in
    //                guard let self = self else { return }
    //                if let image = resultImage {
    //                    news.image = image
    //                    DispatchQueue.main.async {
    //                        self.homeView.setImage(image, forCellAt: indexPath)
    //                    }
    //                }
    //            }
    //        }
    //    }

}
