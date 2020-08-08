//
//  DispatchError.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 08/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

enum DispatchError: Error {
    
    case buildRequestError
    case requestError(Error)
    case unknownResponse
    case parseError
    case networkingError(Int)
    
    var localizedDescription: String {
        switch self {
        case .buildRequestError:
            return "Failed to build URLRequest"
        case .requestError(let error):
            return error.localizedDescription
        case .unknownResponse:
            return "Response is not a valid HTTPURLResponse"
        case .parseError:
            return "Failed to parse JSON data response"
        case .networkingError(let statusCode):
            return "\(statusCode) - \(HTTPURLResponse.localizedString(forStatusCode: statusCode))"
        }
    }
    
}
