//
//  TableTypesHelper.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 14/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

enum TablesType: Int, CaseIterable {
    case a
    case b
    case c
    
    var title : String {
        switch self {
        case .a: return "A"
        case .b: return "B"
        case .c: return "C"
        }
    }
    
    var tableTitle: String {
        switch self {
        case .a: return Localized.tableText + .space + self.title
        case .b: return Localized.tableText + .space + self.title
        case .c: return Localized.tableText + .space + self.title
        }
    }
}
