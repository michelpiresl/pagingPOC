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
    init(viewModel: HomeViewModel) {
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
        homeView.showLoading()
        viewModel.requestNews()
    }
    
    // MARK: - Methods
    private func configureView() {
        view = homeView
        title = "Notícias"
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.getNews(at: indexPath.row)
        if let newsURL = URL(string: news.urlString) {
            UIApplication.shared.open(newsURL)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewTableViewCell.identifier, for: indexPath) as! HomeViewTableViewCell
        let model = viewModel.getNews(at: indexPath.row)
        let service = viewModel.serviceForCell()
        cell.configure(model: model, imageService: service)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scroll = scrollView.contentSize.height - scrollView.contentOffset.y
        if scroll <=  2 * scrollView.bounds.height {
            homeView.showLoading()
            viewModel.requestMoreNews()
        }
    }
        
}

extension HomeViewController: HomePresenter {
    
    func presentIdle() {
        DispatchQueue.main.async {
            self.homeView.reloadTableView()
            self.homeView.hideLoading()
        }
    }
    
    func presentErrorAlert(_ message: String) {
        DispatchQueue.main.async {
            self.homeView.hideLoading()
            self.showErrorAlert(message)
        }
    }
    
}
