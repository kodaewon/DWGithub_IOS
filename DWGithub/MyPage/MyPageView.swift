//
//  MyPageView.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/18.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import SnapKit
import Then

class MyPageView: UIView {
    // MARK: - view propertics
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.sectionHeaderHeight = 40
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.identifier)
    }
    
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
extension MyPageView {
    func setupViews() {
        addAutoLayoutSubViews([tableView])
        
        tableView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
}
