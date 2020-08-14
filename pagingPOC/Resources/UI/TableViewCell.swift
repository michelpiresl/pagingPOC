//
//  TableViewCell.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 07/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

///An UITableViewCell object to be implemented in 'ViewCoding'
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
class TableViewCell: UITableViewCell, ViewCoding, CellIdentifiable {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This object should not be used on xib or storyboard.")
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
