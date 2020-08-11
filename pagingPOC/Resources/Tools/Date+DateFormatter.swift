//
//  Date+DateFormatter.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 11/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

extension Date {
    
    ///Date formatter with short date and medium time for pt_BR standards.
    static var ptBRFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "pt_BR")
        return dateFormatter
    }
    
}
