//
//  HomeView.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 06/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

class HomeView: UIView {

    weak var delegate: HomeViewController? {
        didSet {
            tableView.delegate = delegate
            tableView.dataSource = delegate
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        clipsToBounds = true
        backgroundColor = .lightGray
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    // MARK: - View items
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeViewTableViewCell.self, forCellReuseIdentifier: HomeViewTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.hidesWhenStopped = true
        return loading
    }()
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showLoading() {
        addSubview(loading)

        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        loading.startAnimating()
    }
    
    func hideLoading() {
        loading.stopAnimating()
    }
}
