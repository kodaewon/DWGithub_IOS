//
//  JandiViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

class JandiViewController: BaseViewController {
    
    // MARK: - view properties
    let jandiView = JandiView()
    
    // MARK: - life cycle
    override func loadView() {
        view = jandiView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        
        GitHubService().contributions(username: "kodaewon")
            .subscribe(onNext: { item in
                print("contributions = \(item.items.count)")
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - setup
extension JandiViewController {
    func setupNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationController?.navigationBar.barTintColor = .background
        
        navigationItem.title = "Jandi".localized()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
}
