//
//  HomeViewTableViewCell.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 06/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

final class HomeViewTableViewCell: TableViewCell {
    
    // MARK: - Model
    var date: String? {
        didSet {
            dateLabel.text = date
        }
    }
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var resume: String? {
        didSet {
            resumeLabel.text = resume
        }
    }

    // MARK: - View configuration
    override func configureView() {
        super.configureView()
        contentView.backgroundColor = .white
    }
    
    override func setSubviews() {
        super.setSubviews()
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(resumeLabel)
    }
    
    override func setupConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        dateLabel.setContentHuggingPriority(.init(rawValue: 100), for: .vertical)
        dateLabel.setContentCompressionResistancePriority(.init(rawValue: 100), for: .vertical)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        titleLabel.setContentHuggingPriority(.init(rawValue: 75), for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.init(rawValue: 75), for: .vertical)
        
        resumeLabel.translatesAutoresizingMaskIntoConstraints = false
        resumeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        resumeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        resumeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        resumeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        resumeLabel.setContentHuggingPriority(.init(rawValue: 50), for: .vertical)
        resumeLabel.setContentCompressionResistancePriority(.init(rawValue: 50), for: .vertical)
    }
    
    // MARK: - View items
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var resumeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()

}
