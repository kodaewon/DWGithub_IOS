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
    let titleStackView = UIStackView().then {
        $0.spacing = 12
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    
    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo")
    }
    
    let titleView = UIView().then {
        $0.backgroundColor = .clear
        $0.isHidden = true
    }
    
    let titleLabel = UILabel().then {
        $0.font = .italicSystemFont(ofSize: 31)
        $0.numberOfLines = 2
        $0.textColor = .text
        $0.text = "나만의\n깃헙"
        $0.isHidden = true
    }
    
    let gitHubLoginButton = UIButton().then {
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.backgroundColor = .init(red: 51, green: 51, blue: 51)
        $0.setImage(UIImage(named: "github_icon"), for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        $0.titleLabel?.font = .systemFont(ofSize: 18)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("Log in with GitHub", for: .normal)
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - setup
extension LoginView {
    func setupViews() {
        addAutoLayoutSubViews([titleStackView, gitHubLoginButton])
        
        titleStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.45)
            $0.centerX.equalTo(snp.centerX)
        }
        
        titleStackView.addArrangedSubview(logoImageView)
        titleStackView.addArrangedSubview(titleView)
        
        logoImageView.snp.makeConstraints {
            $0.width.height.equalTo(120)
        }
        
        titleView.addAutoLayoutSubViews([titleLabel])
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        gitHubLoginButton.snp.makeConstraints {
            $0.width.equalTo(220)
            $0.height.equalTo(44)
            $0.center.equalToSuperview()
        }
    }
}
