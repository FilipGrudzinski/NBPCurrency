//
//  ApiError.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 15/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

enum APIError: Int, CaseIterable, Error {
    case notFound = 404
    case badRequest = 400
    
    var message: String {
        switch self {
        case .notFound:
            return Localized.notFoundText
        case .badRequest:
            return Localized.badRequestText
        }
    }
}
