//
//  TablesCodeResponseModel.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 14/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

struct TablesCodeResponseModel {
    let code: String
    let table: String
    let currency: String
    let rates: [TablesCodeRateResponseModel]
    
    struct TablesCodeRateResponseModel {
        let no: String
        let effectiveDate: String
        let bid: Double?
        let ask: Double?
        let mid: Double?
        
        init(ask: Double? = nil, bid: Double? = nil, no: String, mid: Double? = nil, effectiveDate: String) {
            self.ask = ask
            self.bid = bid
            self.no = no
            self.mid = mid
            self.effectiveDate = effectiveDate
        }
    }
}
