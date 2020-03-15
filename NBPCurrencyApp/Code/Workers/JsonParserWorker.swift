//
//  JsonParserWorker.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 13/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JsonParserWorkerProtocol: class {
    func parseTablesJsonData(_ jsonData: JSON) -> TableResponseModel
    func parseRatesCodeJsonData(_ jsonData: JSON) -> TablesCodeResponseModel
}

final class JsonParserWorker: JsonParserWorkerProtocol {
    private enum Constants {
        static let tableKey = "table"
        static let noKey = "no"
        static let effectiveDateKey = "effectiveDate"
        static let tradingDateKey = "tradingDate"
        static let ratesKey = "rates"
        static let currencyKey = "currency"
        static let codeKey = "code"
        static let midKey = "mid"
        static let askKey = "ask"
        static let bidKey = "bid"
    }
    
    func parseTablesJsonData(_ jsonData: JSON) -> TableResponseModel {
        var parsedItem: TableResponseModel?
        
        guard let data = jsonData.array, data.isNotEmpty else {
            return TableResponseModel(table: .empty, effectiveDate: .empty, no: .empty, tradingDate: .empty, rates: [])
        }
        
        jsonData.array?.forEach { item in
            let table = item[Constants.tableKey].stringValue
            let effectiveDate = item[Constants.effectiveDateKey].stringValue
            let no = item[Constants.noKey].stringValue
            let tradingDate = item[Constants.tradingDateKey].stringValue
            var rates: [TableResponseModel.TablesRateResponseModel] = []
            item[Constants.ratesKey].array?.forEach( { element in
                switch table {
                case TablesType.a.title, TablesType.b.title:
                    rates.append(TableResponseModel.TablesRateResponseModel(code: element[Constants.codeKey].stringValue, mid: element[Constants.midKey].doubleValue, currency: element[Constants.currencyKey].stringValue))
                case TablesType.c.title:
                    rates.append(TableResponseModel.TablesRateResponseModel(bid: element[Constants.bidKey].doubleValue, code: element[Constants.codeKey].stringValue, currency: element[Constants.currencyKey].stringValue))
                default: ()
                }
            })
            parsedItem = TableResponseModel(table: table, effectiveDate: effectiveDate, no: no, tradingDate: tradingDate, rates: rates)
        }
        
        guard let item = parsedItem else {
            fatalError()
        }
        
        return item
    }
    
    func parseRatesCodeJsonData(_ jsonData: JSON) -> TablesCodeResponseModel {
        var parsedItem: TablesCodeResponseModel?
        
        let table = jsonData[Constants.tableKey].stringValue
        let code = jsonData[Constants.codeKey].stringValue
        let currency = jsonData[Constants.currencyKey].stringValue.capitalized
        var rates: [TablesCodeResponseModel.TablesCodeRateResponseModel] = []
        
        jsonData[Constants.ratesKey].array?.forEach( { element in
            switch table {
            case TablesType.a.title, TablesType.b.title:
                rates.append(TablesCodeResponseModel.TablesCodeRateResponseModel(no: element[Constants.noKey].stringValue, mid: element[Constants.midKey].doubleValue, effectiveDate: element[Constants.effectiveDateKey].stringValue))
            case TablesType.c.title:
                rates.append(TablesCodeResponseModel.TablesCodeRateResponseModel(ask: element[Constants.askKey].doubleValue, bid: element[Constants.bidKey].doubleValue, no: element[Constants.noKey].stringValue, effectiveDate: element[Constants.effectiveDateKey].stringValue))
            default: ()
            }
        })
        
        parsedItem = TablesCodeResponseModel(code: code, table: table, currency: currency, rates: rates)
        
        guard let item = parsedItem else {
            fatalError()
        }
        
        return item
    }
}
