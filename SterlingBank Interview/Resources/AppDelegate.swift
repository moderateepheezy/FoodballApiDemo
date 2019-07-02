//
//  AppDelegate.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/25/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator!

    var storage: StorageContext?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        
        applicationCoordinator = ApplicationCoordinator(
            rootNavigationController: navigationController
        )
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        window.rootViewController = navigationController
        self.window = window
        
        applicationCoordinator.start()
        
        
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        
        window.makeKeyAndVisible()
        
        
        return true
    }

}

