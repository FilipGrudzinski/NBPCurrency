//
//  MoyaExtensions.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 15/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Moya
import SwiftyJSON
import PromiseKit

extension MoyaProvider where Target: TargetType {
    func request(_ target: Target) -> Promise<JSON> {
        return Promise { resolver in
            request(target) { result in
                switch result {
                case let .success(response):
                    do {
                        let json = try JSON(data: response.data)
                        resolver.fulfill(json)
                    } catch {
                        let apiError: APIError = MoyaProvider.errorHandler(response.statusCode)
                        resolver.reject(apiError)
                    }
                case let .failure(error):
                    resolver.reject(error)
                }
            }
        }
    }
}

extension MoyaProvider {
    static func errorHandler(_ value: Int) -> APIError {
        guard value == APIError.badRequest.rawValue else {
            return APIError.notFound
        }
        return APIError.badRequest
    }
}
