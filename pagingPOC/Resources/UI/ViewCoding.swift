//
//  ViewCoding.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 07/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

///An UIView suited for View Coding.
protocol ViewCoding: UIView {
    
    func configureView()
    func setSubviews()
    func setupConstraints()
    
}
