//
//  AppDelegate.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-05.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
    
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        guard let rootVC = mainSB.instantiateInitialViewController() as? MainViewController else {
            return false
        }
        let navController = UINavigationController(rootViewController: rootVC)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        return true
    }

}

