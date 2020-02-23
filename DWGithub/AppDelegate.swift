//
//  AppDelegate.swift
//  DWGithub
//
//  Created by 고대원 on 2019/12/23.
//  Copyright © 2019 고대원. All rights reserved.
//

import UIKit

import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - Firebase
        FirebaseApp.configure()
        
        // MARK: - Google Admob
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        // MARK: - App Start
        let nc = BaseNavigationController()
        nc.setViewControllers([SplashViewController()], animated: false)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = nc
        
        // MARK: - 사용자 설정 Interface Mode 설정
        if #available(iOS 13.0, *) {
            if let userInterFaceType = UserDefaults.standard.object(forKey: USER_INTERFACEMODE) as? String {
                if userInterFaceType == "Light Mode".localized() {
                    window.overrideUserInterfaceStyle = .light
                } else if userInterFaceType == "Dark Mode".localized() {
                    window.overrideUserInterfaceStyle = .dark
                } else {
                    window.overrideUserInterfaceStyle = .unspecified
                }
            }
        }
        
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}
