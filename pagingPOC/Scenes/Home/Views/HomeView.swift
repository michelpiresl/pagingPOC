//
//  HomeView.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 06/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

final class HomeView: View {
    
    // MARK: - Delegate
    weak var delegate: HomeViewController? {
        didSet {
            tableView.delegate = delegate
            tableView.dataSource = delegate
        }
    }
    
    // MARK: - View configuration
    override func configureView() {
        super.configureView()
        backgroundColor = .white
    }
    
    override func setSubviews() {
        super.setSubviews()
        addSubview(tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
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
        tableView.rowHeight = 300
//        tableView.estimatedRowHeight = 250
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Methods
    func reloadTableView() {
        tableView.reloadData()
    }
        
}
