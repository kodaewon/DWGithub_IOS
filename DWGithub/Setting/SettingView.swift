//
//  SettingView.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import SnapKit
import Then

class SettingView: UIView {
    
    // MARK: - view properties
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.bounces = true
        $0.sectionHeaderHeight = 40
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
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
extension SettingView {
    func setupViews() {
        addAutoLayoutSubViews([tableView])
        
        tableView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(snp.topMargin)
        }
    }
}
