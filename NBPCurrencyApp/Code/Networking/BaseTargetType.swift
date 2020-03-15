//
//  BaseTargetType.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 11/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
    var baseURL: URL {
        return URL(string: "http://api.nbp.pl/api/exchangerates/")!
    }

    //  There is no reason to implement headers property for every target for now
    // if tere'll be need to this we can achieve this by setup plugin for MoyaProvider once
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    // Since this is .post method for all requests we can set this as default option for this protocol
    var method: Moya.Method {
        return .get
    }
    
    // There is no stub data for testing so the data is set to empty (in extension) by default
    var sampleData: Data {
        return Data()
    }
}
