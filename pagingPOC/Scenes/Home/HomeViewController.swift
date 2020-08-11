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
    
    // MARK: - ViewModel
    private let viewModel: HomeViewModel
    
    // MARK: - Init
    init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.presenter = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.requestNews()
    }
    
    // MARK: - Methods
    private func configureView() {
        view = homeView
        title = "Notícias"
    }
    

    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = viewModel.getNews(at: indexPath) else { return }
        if let newsURL = URL(string: news.urlString) {
            UIApplication.shared.open(newsURL)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.requestMoreNews(at: indexPath)
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewTableViewCell.identifier, for: indexPath) as? HomeViewTableViewCell {
            let news = viewModel.getNews(at: indexPath)
            cell.model = news
            return cell
        }
        return UITableViewCell()
    }
        
}

extension HomeViewController: HomePresenter {
    
    func presentLoading() {
        homeView.showLoading()
    }
    
    func presentIdle() {
        homeView.reloadTableView()
        homeView.hideLoading()
    }
    
    func presentErrorAlert(_ message: String) {
        homeView.hideLoading()
        showErrorAlert(message)
    }
    
}
