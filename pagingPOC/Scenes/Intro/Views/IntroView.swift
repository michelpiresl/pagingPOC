//
//  IntroView.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 13/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

@objc protocol IntroViewDelegate {
    
    @objc func didTapIntroButton()
    
}

final class IntroView: View {
    
    // MARK: - Delegate
    weak var delegate: IntroViewDelegate?
    
    // MARK: - View configuration
    override func configureView() {
        super.configureView()
        backgroundColor = .white
    }
    
    override func setSubviews() {
        super.setSubviews()
        addSubview(introButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        introButton.translatesAutoresizingMaskIntoConstraints = false
        introButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        introButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    // MARK: - View items
    private lazy var introButton: UIButton = {
        let button = UIButton()
        button.setTitle("News", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(delegate, action: #selector(delegate?.didTapIntroButton), for: .touchUpInside)
        return button
    }()
    
}
