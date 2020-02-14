//
//  SettingTableViewCell.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/13.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import SnapKit
import Then

enum SettingTableViewCellType {
    case normal, info, toggle
}

class SettingTableViewCell: UITableViewCell {
    
    // MARK: - view properties
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 8
    }
    
    let titleLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.lineBreakMode = .byTruncatingTail
        $0.textColor = .text
        $0.text = ""
    }
    
    let infoLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.lineBreakMode = .byTruncatingTail
        $0.textColor = .text
        $0.text = ""
        $0.isHidden = true
    }
    
    let toggleSwitch = UISwitch().then {
        $0.tintColor = .baisc
        $0.isHidden = true
    }
    
    // MARK: - properties
    static let identifier = "MyTableViewCell"
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - update
extension SettingTableViewCell {
    func update(_ type: SettingTableViewCellType) {
        infoLabel.isHidden = true
        toggleSwitch.isHidden = true
        
        switch type {
        case .info:
            infoLabel.isHidden = false
        case .toggle:
            toggleSwitch.isHidden = false
        default:
            return
        }
    }
}

// MARK: - setup
extension SettingTableViewCell {
    func setupViews() {
        addAutoLayoutSubViews([stackView])
        
        stackView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.bottom.equalToSuperview().offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(toggleSwitch)
        
        infoLabel.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(24)
        }
    }
}
