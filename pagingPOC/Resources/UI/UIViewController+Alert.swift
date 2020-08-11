//
//  UIViewController+Alert.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 11/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

extension UIViewController {
    
    ///Simple Alert for Error with OK button.
    func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "Erro",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
