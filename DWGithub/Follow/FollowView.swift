//
//  FollowView.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/19.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import Then
import SnapKit

class FollowView: UIView {
    // MARK: - view properties
    let tableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.register(FollowTableViewCell.self, forCellReuseIdentifier: FollowTableViewCell.identifier)
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setup
extension FollowView {
    func setupViews() {
        addAutoLayoutSubViews([tableView])
        
        tableView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
}
 
