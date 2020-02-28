//
//  SplashView.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import SnapKit
import Then

class SplashView: UIView {
    let logoImageView = UIImageView().then {
        $0.image =  UIImage(named: "logo")
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - setup
extension SplashView {
    func setupViews() {
        self.backgroundColor = .background
        
        addAutoLayoutSubViews([logoImageView])
        
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
