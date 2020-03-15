//
//  TableResponseModel.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 13/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

struct TableResponseModel {
    let table: String
    let effectiveDate: String
    let no: String
    let tradingDate: String?
    let rates: [TablesRateResponseModel]
    
    struct TablesRateResponseModel {
        let ask: Double?
        let bid: Double?
        let code: String
        let mid: Double?
        let currency: String
        
        init(ask: Double? = nil, bid: Double? = nil, code: String, mid: Double? = nil, currency: String) {
            self.ask = ask
            self.bid = bid
            self.code = code
            self.mid = mid
            self.currency = currency.capitalized
        }
    }
}
