//
//  HomeViewTableViewCell.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 06/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

class HomeViewTableViewCell: UITableViewCell {

    static var identifier: String {
        return String(describing: type(of: self))
    }
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         configView()
         setupConstraints()

     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(resumeLabel)
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        
        resumeLabel.translatesAutoresizingMaskIntoConstraints = false
        resumeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        resumeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        resumeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        resumeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true

    }
    
    // MARK: - View items
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private lazy var resumeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10)
        return label
    }()

}
