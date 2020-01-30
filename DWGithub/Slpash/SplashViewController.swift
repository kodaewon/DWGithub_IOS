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
        
        goMain()
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
