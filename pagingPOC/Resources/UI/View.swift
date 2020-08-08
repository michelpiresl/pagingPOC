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
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setSubviews()
        setupConstraints()
        configureView()
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
    
}
