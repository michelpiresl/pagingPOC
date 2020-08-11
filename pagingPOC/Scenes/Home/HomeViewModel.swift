//
//  HomeViewModel.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 11/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

protocol HomePresenter: AnyObject {
    
    func presentLoading()
    func presentIdle()
    func presentErrorAlert(_ message: String)
    
}

final class HomeViewModel {
    
    // MARK: - Service
    private let service: SearchForNewsService
    weak var presenter: HomePresenter?
    
    // MARK: - Init
    init(
        service: SearchForNewsService
    ) {
        self.service = service
    }
    
    // MARK: - Models
    private var news: [News] = []
    private var numberOfNews: Int?
    private var pageSize: Int = 10
    private var page: Int = 1
    private var query: String = "apple"
    
    // MARK: - Exposed Info
    func getNews(at indexPath: IndexPath) -> News? {
        guard indexPath.row < news.count else { return nil }
        return news[indexPath.row]
    }
    
    func newsCount() -> Int {
        return news.count
    }
    
    func newsTotal() -> Int {
        return numberOfNews ?? 0
    }
    
    // MARK: - Service Requests
    func requestNews() {
        presenter?.presentLoading()
        service.searchFor(query, page: page, pageSize: pageSize) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let newsList):
                self.numberOfNews = newsList.numberOfNews
                self.news += newsList.news
                DispatchQueue.main.async {
                    self.presenter?.presentIdle()
                }
            case .failure:
                if self.news.count == 0 {
                    DispatchQueue.main.async {
                        self.presenter?.presentErrorAlert("Não foi possível carregar notícias")
                    }
                }
            }
        }
    }
    
    // MARK: - Methods
    func requestMoreNews(at indexPath: IndexPath) {
        if indexPath.row == news.count - 1 { // Se for a última célula
            if let total = numberOfNews, total > news.count { // Se tem mais notícias para exibir
                page += 1
                requestNews()
            }
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
