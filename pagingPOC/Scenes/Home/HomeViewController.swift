//
//  HomeViewController.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 06/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - View
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Service
    private let service: SearchForNewsService = SearchForNewsService()
    
    // MARK: - Model
    private var news: [News] = []
    private var numberOfNews: Int?
    private var pageSize: Int = 10
    private var page: Int = 1
    private var query: String = "apple"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
        requestNews()
    }
    
    // MARK: - Methods
    private func initialConfiguration() {
        view = homeView
        title = "Notícias"
    }
    
    private func reloadData() {
        homeView.reloadTableView()
    }

    // MARK: - Services
    private func requestNews() {
        homeView.showLoading()
        service.searchFor(query, page: page, pageSize: pageSize) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let newsList):
                self.numberOfNews = newsList.numberOfNews
                self.news += newsList.news
                DispatchQueue.main.async {
                    self.reloadData()
                    self.homeView.hideLoading()
                }
            case .failure:
                if self.news.count == 0 {
                    DispatchQueue.main.async {
                        self.homeView.hideLoading()
                        self.showErrorAlert()
                    }
                }
            }
        }
    }
    
    private func setImageForCell(at indexPath: IndexPath) {
        let news = self.news[indexPath.row]
        if let cellImage = news.image {
            homeView.setImage(cellImage, forCellAt: indexPath)
        } else {
            guard let url = URL(string: news.imageUrlString ?? "") else { return }
            service.requestImage(from: url) { [weak self] (resultImage) in
                guard let self = self else { return }
                if let image = resultImage {
                    DispatchQueue.main.async {
                        self.homeView.setImage(image, forCellAt: indexPath)
                    }
                }
            }
        }
    }
    
    // MARK: - Alert for Error
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Erro",
                                      message: "Não foi possível carregar notícias",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thisNews = self.news[indexPath.row]
        if let newsURL = URL(string: thisNews.urlString) {
            UIApplication.shared.open(newsURL)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == news.count - 1 { // Se for a última célula
            if let total = numberOfNews, total > news.count { // Se tem mais notícias para exibir
                page += 1
                requestNews()
            }
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewTableViewCell.identifier, for: indexPath) as? HomeViewTableViewCell {
            let news = self.news[indexPath.row]
            cell.date = news.timeString
            cell.title = news.title
            cell.resume = news.description
            setImageForCell(at: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? HomeViewTableViewCell else { return }
        cell.newsImage = nil
    }
    
}
