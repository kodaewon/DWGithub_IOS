//
//  JandiCollectionHeaderView.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/20.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import Then
import SnapKit

class JandiCollectionHeaderView: UICollectionReusableView {
    
    // MARK: - view properties
    let titleLabel = UILabel().then {
        $0.font = .regular(13)
        $0.textColor = .groupText
        $0.text = ""
    }
    
    // MARK: - properties
    static let identifier = "JandiCollectionHeaderView"
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .groupBackground
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setup
extension JandiCollectionHeaderView {
    func setupViews() {
        addAutoLayoutSubViews([titleLabel])
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
}
