//
//  GeneralAPIService.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 11/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation
import Moya

enum GeneralAPIService {
    case getTables(String)
    case getTableCodeData(TableCodeRequestModel)
    case getDateRates(DateRatesRequestModel)
}

extension GeneralAPIService: TargetType {
    var path: String {
        switch self {
        case let .getTables(request):
            return "tables/\(request)"
        case let .getTableCodeData(request):
            return "rates/\(request.table)/\(request.code)"
        case let .getDateRates(request):
            return "rates/\(request.table)/\(request.code)/\(request.startDate)/\(request.endDate)"
        }
    }
        
    var task: Task {
        switch self {
        case .getTables, .getTableCodeData, .getDateRates:
            return .requestPlain
        }
    }
}
