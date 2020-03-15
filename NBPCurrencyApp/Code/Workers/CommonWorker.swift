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
        return provider.request(.getTables(type))
    }
    
    func getTableCodeData(_ table: String, _ code: String) -> Promise<JSON> {
        let requestModel = TableCodeRequestModel(table: table, code: code)
        return provider.request(.getTableCodeData(requestModel))
    }
    
    func getDateRates(_ table: String, _ code: String, _ startDate: String, _ endDate: String) -> Promise<JSON> {
        let requestModel = DateRatesRequestModel(table: table, code: code, startDate: startDate, endDate: endDate)
        return provider.request(.getDateRates(requestModel))
    }
}
