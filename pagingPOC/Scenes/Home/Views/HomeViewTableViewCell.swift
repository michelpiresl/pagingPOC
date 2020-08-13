//
//  HomeViewTableViewCell.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 06/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

final class HomeViewTableViewCell: TableViewCell {
    
    // MARK: Model injection
    func configure(model: News, imageService: SearchForNewsServiceProtocol) {
        dateLabel.text = model.timeString
        titleLabel.text = model.title
        resumeLabel.text = model.description
        setImage(service: imageService, urlString: model.imageUrlString)
    }
    
    // MARK: - Properties
    
    private lazy var imageViewHeight: NSLayoutConstraint = newsImageView.heightAnchor.constraint(equalToConstant: 0)

    // MARK: - View configuration
    override func configureView() {
        super.configureView()
        contentView.backgroundColor = .white
    }
    
    override func prepareForReuse() {
        newsImageView.image = nil
    }
    
    override func setSubviews() {
        super.setSubviews()
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(newsImageView)
        contentView.addSubview(resumeLabel)
    }
    
    override func setupConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        dateLabel.setContentHuggingPriority(.init(rawValue: 100), for: .vertical)
        dateLabel.setContentCompressionResistancePriority(.init(rawValue: 100), for: .vertical)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        titleLabel.setContentHuggingPriority(.init(rawValue: 75), for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.init(rawValue: 75), for: .vertical)
        
        resumeLabel.translatesAutoresizingMaskIntoConstraints = false
        resumeLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 4).isActive = true
        resumeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        resumeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        resumeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        resumeLabel.setContentHuggingPriority(.init(rawValue: 50), for: .vertical)
        resumeLabel.setContentCompressionResistancePriority(.init(rawValue: 50), for: .vertical)

        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        newsImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        newsImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        imageViewHeight.isActive = true
    }
    
    // MARK: - Methods
    ///Set an image for cell by checking model for image. If model doesnt have an image, it is requested using imageURL.
    private func setImage(service: SearchForNewsServiceProtocol, urlString: String?) {
        guard let url = URL(string: urlString ?? "") else { return }
        service.requestImage(from: url) { [weak self] (resultImage) in
            guard let self = self else { return }
            if let image = resultImage {
                DispatchQueue.main.async {
                    self.imageViewHeight.constant = 100
                    self.newsImageView.image = image
                }
            }
        }
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
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

}
