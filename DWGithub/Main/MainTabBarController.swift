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
        
        tabBar.tintColor = .text
        
        initTabBar()
    }
}

// MARK: - view init
extension MainTabBarController {
    func initTabBar() {
        var tabbarViewControlls: [UIViewController] = []
        for (title, imageName, vc) in [("Search".localized(), "tab_search", SearchViewController()),
                            ("Repositories".localized(), "book", RepositoriesViewController()),
                            ("Jandi".localized(), "jandi", JandiViewController()),
                            ("Setting".localized(), "setting", SettingViewController())] as! [(String, String, UIViewController)] {

                                let nc = BaseNavigationController()
                                nc.navigationBar.tintColor = .tint
                                nc.title = title
                                nc.tabBarItem.image = UIImage(named: imageName)
                                nc.setViewControllers([vc], animated: true)
                                vc.navigationItem.title = title
                                tabbarViewControlls.append(nc)
        }
        
        viewControllers = tabbarViewControlls
    }
}
