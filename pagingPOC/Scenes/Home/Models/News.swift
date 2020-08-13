//
//  HeadlinesModel.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 06/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

struct News {
    
    let time: Date
    let source: String
    let title: String
    let description: String
    let imageUrlString: String?
    let urlString: String

    var timeString: String {
        return Date.ptBRFormatter.string(from: time)
    }
        
    init(
        time: Date,
        source: String,
        title: String,
        description: String,
        urlString: String,
        imageUrlString: String?
    ) {
        self.source = source
        self.title = title
        self.description = description
        self.urlString = urlString
        self.imageUrlString = imageUrlString
        self.time = time
    }
    
}
