//
//  GitHubViewModel.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/07.
//  Copyright © 2020 고대원. All rights reserved.
//

import RxCocoa
import RxSwift

class GitHubViewModel {
    
    // input
    
    // output
    var loadURL: PublishSubject<String>
    
    init() {
        let loadOb = PublishSubject<String>()
        
        loadURL = loadOb.asObserver()
    }
}
