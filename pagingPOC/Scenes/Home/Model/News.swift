//
//  HeadlinesModel.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 06/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

struct News {
    
    var time: Date
    var source: String
    var title: String
    var description: String
    var imageUrlString: String?
    var image: UIImage?
    var urlString: String
    
    
    var timeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "pt_BR")
        return dateFormatter.string(from: time)
    }
    
    init(time: String, source: String, title: String, description: String, urlString: String, imageUrlString: String?) {
        self.source = source
        self.title = title
        self.description = description
        self.urlString = urlString
        self.imageUrlString = imageUrlString
        
        let dateFormatter = ISO8601DateFormatter()
        self.time = dateFormatter.date(from: time) ?? Date()
    }
    
}
