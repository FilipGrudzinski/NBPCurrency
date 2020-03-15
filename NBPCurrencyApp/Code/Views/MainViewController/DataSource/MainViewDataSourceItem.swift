//
//  MainViewDataSourceItem.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 12/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

struct MainViewDataSourceItem {
    let table: String
    let title: String
    let code: String
    let mid: Double?
    let bid: String?
    var ask: String? = nil
    let effectiveDate: String
}
