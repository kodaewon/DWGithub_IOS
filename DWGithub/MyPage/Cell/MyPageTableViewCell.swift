//
//  MyPageTableViewCell.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/18.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import SnapKit
import Then

class MyPageTableViewCell: UITableViewCell {
    // MARK: - view properties
    let titleLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = .regular(17)
        $0.textAlignment = .left
        $0.textColor = .text
        $0.text = ""
    }
    
    let descLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.lineBreakMode = .byTruncatingTail
        $0.font = .regular(17)
        $0.textAlignment = .left
        $0.textColor = .text
        $0.text = ""
    }
    
    // MARK: - properties
    static let identifier = "MyPageTableViewCell"
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setup
extension MyPageTableViewCell {
    func setupViews() {
        addAutoLayoutSubViews([titleLabel, descLabel])
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        descLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.right).offset(8)
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }
}
