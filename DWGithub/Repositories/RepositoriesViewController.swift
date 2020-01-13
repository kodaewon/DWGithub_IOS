//
//  RepositoriesViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    let repositoriesView = RepositoriesView()
    
    override func loadView() {
        view = repositoriesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
