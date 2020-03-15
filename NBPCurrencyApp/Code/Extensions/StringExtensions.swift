//
//  StringExtensions.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 11/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

extension String {
    static let empty = ""
    static let space = " "
    static let dash = "-"
    static let plus = "+"
    static let dot = "."
    static let threeDot = "..."
    static let comma = ","
    static let newLine = "\n"
    static let backspace = "/"
    static let colon = ":"
    static let openParenthesis = "("
    static let closeParenthesis = ")"
    static let hourMinuteFormat = "HH:mm"
    static let dateShortFormat = "dd.MM.yy"
    static let dateFormatWithDoubleSpaceAtTheEnd = "dd.MM.yy "
    static let apiDateFormat = "yyyy-MM-dd"
    static let spaceDashSpace = " - "
    static let threDecimalPlacesFormat = "%.3f"
}

enum Digit {
    static let zero = 0
    static let one = 1
    static let two = 2
    static let three = 3
    static let four = 4
    static let five = 5
    static let six = 6
    static let eight = 8
    static let nine = 9
    static let hour = 60
    static let hundred = 100
}
