//
//  AppDelegate.swift
//  DWGithub
//
//  Created by 고대원 on 2019/12/23.
//  Copyright © 2019 고대원. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let nc = BaseNavigationController()
        nc.setViewControllers([SplashViewController()], animated: false)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = nc
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}
