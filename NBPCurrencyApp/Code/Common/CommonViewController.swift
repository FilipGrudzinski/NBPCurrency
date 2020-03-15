//
//  CommonViewController.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 14/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {

    var activityIndicator: ActivityIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController {
            activityIndicator = ActivityIndicator(navigationController.view)
        } else {
            activityIndicator = ActivityIndicator(view)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bringSubviewToFront(activityIndicator)
    }
}
