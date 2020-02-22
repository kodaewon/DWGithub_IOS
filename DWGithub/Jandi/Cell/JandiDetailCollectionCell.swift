//
//  JandiDetailCollectionCell.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/21.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import Then
import SnapKit

class JandiDetailCollectionCell: UICollectionViewCell {
    
    // MARK: - view properties
    let dateLabel = UILabel().then {
        $0.textColor = .text
        $0.text = ""
    }
    
    let countLabel = UILabel().then {
        $0.textColor = .text
        $0.text = ""
    }
    
    // MARK: - properties
    static let identifier = "JandiDetailCollectionCell"
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setup
extension JandiDetailCollectionCell {
    func setupViews() {
        addAutoLayoutSubViews([dateLabel, countLabel])
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.equalToSuperview().offset(16)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
        }
    }
}
