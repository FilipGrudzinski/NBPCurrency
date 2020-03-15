//
//  AppDelegate.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 11/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var coordinator: ApplicationCoordinatorProtocol?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        
        coordinator = ApplicationCoordinator(window: window)
        coordinator?.start()
        
        return true
    }
}
