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


//{
//  "table" : "C",
//  "code" : "USD",
//  "currency" : "dolar amerykański",
//  "rates" : [
//    {
//      "effectiveDate" : "2020-03-13",
//      "bid" : 3.8841999999999999,
//      "ask" : 3.9626000000000001,
//      "no" : "051\/C\/NBP\/2020"
//    }
//  ]
//}

//{
//  "currency" : "afgani (Afganistan)",
//  "rates" : [
//    {
//      "effectiveDate" : "2020-03-11",
//      "no" : "010\/B\/NBP\/2020",
//      "mid" : 0.050104000000000003
//    }
//  ],
//  "code" : "AFN",
//  "table" : "B"
//}
//
//{
//  "rates" : [
//    {
//      "no" : "051\/A\/NBP\/2020",
//      "mid" : 0.1229,
//      "effectiveDate" : "2020-03-13"
//    }
//  ],
//  "currency" : "bat (Tajlandia)",
//  "code" : "THB",
//  "table" : "A"
//}

