//
//  UIView+Loading.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 07/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

extension UIView {
    
    ///Display a loading indicator in front of the UIView.
    ///
    ///To remove, call: `.hideloading()`
    func showLoading() {
        viewWithTag(2)?.removeFromSuperview()
        let loading = UIActivityIndicatorView(style: .medium)
        loading.hidesWhenStopped = true
        loading.tag = 2
        let color = UIColor.black.withAlphaComponent(0.1)
        loading.backgroundColor = color
        addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.topAnchor.constraint(equalTo: topAnchor).isActive = true
        loading.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        loading.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        loading.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        loading.startAnimating()
    }
    ///Hides a loading indicator is there is one.
    func hideLoading() {
        if let loading = viewWithTag(2) as? UIActivityIndicatorView {
            loading.stopAnimating()
            loading.removeFromSuperview()
        }
    }
    
}
