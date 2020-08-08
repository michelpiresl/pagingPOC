//
//  HomeViewController.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 06/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    private var page: Int = 1
    private var query: String = "swift"
    
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
        service.searchFor(query, page: page) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let newsList):
                self.numberOfNews = newsList.numberOfNews
                self.news += newsList.news
                self.reloadData()
                self.homeView.hideLoading()
            case .failure(_):
                if self.news.count == 0 {
                    self.homeView.hideLoading()
                    self.showErrorAlert()
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
            return cell
        }
        return UITableViewCell()
    }
    
}
