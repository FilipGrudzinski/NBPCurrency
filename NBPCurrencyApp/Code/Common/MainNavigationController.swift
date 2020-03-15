//
//  MainNavigationController.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 11/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class MainNavigationController: UINavigationController {
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let backButton = UIBarButtonItem(title: .empty, style: .plain, target: nil, action: nil)
        topViewController?.navigationItem.backBarButtonItem = backButton
        navigationBar.barTintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationBar.tintColor = .black
    }
}
