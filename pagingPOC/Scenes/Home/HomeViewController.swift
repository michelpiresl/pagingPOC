//
//  HomeViewController.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 06/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.delegate = self
        return view
    }()
        
    private var headlines: [HeadlinesModel] = []
    private var numberOfHeadlines: Int?
    private var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        requestSearchFor()
//        requestHeadlines()

    }
    
    private func config() {
        view = homeView
        title = "Notícias"
    }
    
    private func requestSearchFor(_ query: String = "swift", page: Int = 1) {
        homeView.showLoading()
        Api.shared.searchFor(query, page: page) { [weak self] (headlines) in
            guard let self = self else { return }
            self.numberOfHeadlines = min(headlines.totalResults ?? 0, 100)
            headlines.articles.forEach { article in
                if let article = article {
                    let headline = HeadlinesModel(time: article.publishedAt ?? "",
                                                  source: article.source?.name ?? "",
                                                  title: article.title ?? "",
                                                  description: article.description ?? "")
                    self.headlines.append(headline)
                }
            }
            self.reloadData()
            self.homeView.hideLoading()
        }
    }
    
    private func requestHeadlines(page: Int = 1) {
        homeView.showLoading()
        Api.shared.topHeadlines(page: page) { [weak self] (headlines) in
            guard let self = self else { return }
            self.numberOfHeadlines = headlines.totalResults
            headlines.articles.forEach { article in
                if let article = article {
                    let headline = HeadlinesModel(time: article.publishedAt ?? "",
                                                  source: article.source?.name ?? "",
                                                  title: article.title ?? "",
                                                  description: article.description ?? "")
                    self.headlines.append(headline)
                }
            }
            self.reloadData()
            self.homeView.hideLoading()
        }
    }
    
    private func reloadData() {
        homeView.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    private var count = 0

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        count += 1
        print("[\(count)] cellForRowAt called -> Row: [\(indexPath.row+1)] || Headlines: [\(headlines.count)] || TotalItems: [\(numberOfHeadlines ?? 0)]")
        if indexPath.row == headlines.count - 1 { // Se for a última célula
            if let total = numberOfHeadlines, total > headlines.count { // Se tem mais notícias para exibir
                page += 1
                requestSearchFor(page: page)
//                requestHeadlines(page: page)
            }
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewTableViewCell.identifier, for: indexPath) as? HomeViewTableViewCell {
            let headline = headlines[indexPath.row]
            cell.date = headline.timeString
            cell.title = headline.title
            cell.resume = headline.description
            return cell
        }
        return UITableViewCell()
    }
    
}
