//
//  LoginView.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import SnapKit
import Then

class LoginView: UIView {
    
    // MARK: - view properties
    let gitHubLoginButton = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("Login", for: .normal)
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - setup
extension LoginView {
    func setupViews() {
        addAutoLayoutSubViews([gitHubLoginButton])
        
        gitHubLoginButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
