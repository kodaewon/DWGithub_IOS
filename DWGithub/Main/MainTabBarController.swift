//
//  MainTabBarController.swift
//  DWGithub
//
//  Created by 고대원 on 2019/12/23.
//  Copyright © 2019 고대원. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTabBar()
    }
}

// MARK: - view init
extension MainTabBarController {
    func initTabBar() {
        var tabbarViewControlls: [UIViewController] = []
        for (title, vc) in [("Search", SearchViewController()),
                            ("Repositories", RepositoriesViewController()),
                            ("Jandi", JandiViewController()),
                            ("Setting", SettingViewController())] as! [(String, UIViewController)] {

                                let nc = BaseNavigationController()
                                nc.title = title
                                nc.setViewControllers([vc], animated: true)
                                vc.navigationItem.title = title
                                tabbarViewControlls.append(nc)
        }
        
        viewControllers = tabbarViewControlls
    }
}
