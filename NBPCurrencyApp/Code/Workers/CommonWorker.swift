//
//  CommonWorker.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 11/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Moya
import Alamofire
import PromiseKit
import SwiftyJSON

protocol CommonWorkerProtocol {
    func getTablesData(_ type: String) -> Promise<JSON>
    func getTableCodeData(_ table: String, _ code: String) -> Promise<JSON>
    func getDateRates(_ table: String, _ code: String, _ startDate: String, _ endDate: String) -> Promise<JSON>
}

final class CommonWorker: CommonWorkerProtocol {
    let provider = MoyaProvider<GeneralAPIService>()
    
    func getTablesData(_ type: String) -> Promise<JSON> {
        return Promise { resolver in
            provider.request(.getTables(type)) { result in
                switch result {
                case let .success(response):
                    do {
                        let json = try JSON(data: response.data)
                        resolver.fulfill(json)
                    } catch {
                        resolver.reject(error)
                    }
                case let .failure(error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    func getTableCodeData(_ table: String, _ code: String) -> Promise<JSON> {
        let requestModel = TableCodeRequestModel(table: table, code: code)
        return Promise { resolver in
            provider.request(.getTableCodeData(requestModel)) { result in
                switch result {
                case let .success(response):
                    do {
                        let json = try JSON(data: response.data)
                        resolver.fulfill(json)
                    } catch {
                        resolver.reject(error)
                    }
                case let .failure(error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    func getDateRates(_ table: String, _ code: String, _ startDate: String, _ endDate: String) -> Promise<JSON> {
        let requestModel = DateRatesRequestModel(table: table, code: code, startDate: startDate, endDate: endDate)
        return Promise { resolver in
            provider.request(.getDateRates(requestModel)) { result in
                switch result {
                case let .success(response):
                    do {
                        let json = try JSON(data: response.data)
                        resolver.fulfill(json)
                    } catch {
                        let apiError: APIError = self.errorHandler(response.statusCode)
                        resolver.reject(apiError)
                    }
                case let .failure(error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    private func errorHandler(_ value: Int) -> APIError {
        guard value == APIError.badRequest.rawValue else {
            return APIError.notFound
          }
        return APIError.badRequest
    }
}
