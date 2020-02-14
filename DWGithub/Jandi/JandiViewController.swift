//
//  JandiViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

class JandiViewController: UIViewController {
    
    let jandiView = JandiView()
    
    override func loadView() {
        view = jandiView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - setup
extension JandiViewController {
    func setupNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationController?.navigationBar.barTintColor = .background
        
        navigationItem.title = "Jandi"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.largeContentTitle = "Jandi"
        }
    }
}
