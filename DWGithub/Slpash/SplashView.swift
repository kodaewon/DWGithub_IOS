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
    
    // MARK: - view properties
    let appNameLabel = UILabel().then {
        $0.font = .bold(15)
        $0.textColor = .text
        $0.text = "DWGithub"
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
        self.backgroundColor = .white
        
        addAutoLayoutSubViews([appNameLabel])
        
        appNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
