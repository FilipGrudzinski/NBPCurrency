//
//  RatesRequestModel.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 11/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

struct DateRatesRequestModel {
    let table: String
    let code: String
    let startDate: String
    let endDate: String
}
