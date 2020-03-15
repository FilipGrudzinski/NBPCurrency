//
//  UIFontExtension.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 14/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

extension UIFont {
    enum Size: CGFloat {
        case smaller = 10.0
        case small = 12.0
        case medium = 14.0
        case normal = 16.0
        case big = 18.0
        case large = 20.0
        case huge = 22.0

        var size: CGFloat {
            return self.rawValue
        }
    }

    static func font(with type: Weight = .regular, size: Size = .medium) -> UIFont {
        return .systemFont(ofSize: size.size, weight: type)
    }
}
