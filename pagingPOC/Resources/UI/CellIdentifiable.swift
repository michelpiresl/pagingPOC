//
//  CellIdentifiable.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 07/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

///A cell type with 'identifier' property which returns a string describing self.
protocol CellIdentifiable {
    
    ///Returns a string describing self.
    static var identifier: String { get }
    
}

extension CellIdentifiable where Self : UITableViewCell {
    
    static var identifier: String {
        return String(describing: type(of: self))
    }
    
}
