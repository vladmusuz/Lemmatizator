//
//  AppDelegate.swift
//  Lemmatizator
//
//  Created by g00dm0us3 on 8/17/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let navigationController = UINavigationController()
        let dependencies = Dependencies()
        let router = Router(navigationController: navigationController, dependencies: dependencies)
        
        router.initialViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

