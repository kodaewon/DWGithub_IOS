//
//  SplashViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    let splashView = SplashView()

    override func loadView() {
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.goMain()
        return
        if let token = UserDefaults.standard.object(forKey: USER_TOKEN) as? String {
            GitHubAPI.userInfo(token: token) { (userInfo) in
                guard let userInfo = userInfo else {
                    self.goLogin()
                    return
                }
                
                if let groupUserDefault = UserDefaults(suiteName: "group.DWGitHub") {
                    groupUserDefault.setValue(userInfo.login, forKey: "login")
                    groupUserDefault.synchronize()
                }
                
                UserInfo.shared = userInfo
                UserInfo.shared.token = token
                self.goMain()
            }
        } else {
            self.goLogin()
        }
    }
}

// MARK: - page move
extension SplashViewController {
    func goLogin() {
        let vc = LoginViewController()
        self.navigationController?.setViewControllers([vc], animated: false)
    }
    
    func goMain() {
        let vc = MainTabBarController()
        navigationController?.setViewControllers([vc], animated: true)
    }
}
