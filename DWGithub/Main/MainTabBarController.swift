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
        let serchViewContoller = SearchViewController()
        serchViewContoller.title = "Search"
        
        let repositoriesViewController = RepositoriesViewController()
        repositoriesViewController.title = "Repositories"
        
        let jandiViewController = JandiViewController()
        jandiViewController.title = "Jandi"
        
        let myViewController = MyViewController()
        myViewController.title = "My"
        
        viewControllers = [serchViewContoller, repositoriesViewController, jandiViewController, myViewController]
    }
}
