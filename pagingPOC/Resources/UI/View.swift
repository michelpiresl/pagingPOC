//
//  View.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 07/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

///An UIView object to be implemented in 'ViewCoding'.
///
///Subclass should override and call super methods:
///```
///override func configureView() {
///    super.configureView()
///    // View initial configuration
///}
///```
///```
///override func setSubviews() {
///    super.setSubview()
///    // addSubview(view: UIView)
///```
///```
///override func setupConstraints() {
///    super.setupConstraints()
///    // Setup constraints for view items
///}
class View: UIView, ViewCoding {
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.hidesWhenStopped = true
        let color = UIColor.black.withAlphaComponent(0.1)
        loading.backgroundColor = color
        return loading
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Used to define inicial atributtes for View.
    func configureView() {
        clipsToBounds = true
    }
    
    ///Used to add subviews.
    func setSubviews() {}
    
    ///Used to setup constraints for each subview.
    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = true
    }
    
    ///Display a loading indicator in front of the UIView.
    ///
    ///To remove, call: `.hideloading()`
    func showLoading() {
        addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        loadingView.startAnimating()
    }
    
    ///Hides a loading indicator is there is one.
    func hideLoading() {
        loadingView.stopAnimating()
        loadingView.removeFromSuperview()
    }
    
}
