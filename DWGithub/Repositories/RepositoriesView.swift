//
//  RepositoriesView.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import Then

class RepositoriesView: UIView {
    // MARK: - view properties
    let tableView = UITableView().then {
//        $0.refreshControl = UIRefreshControl()
//        $0.refreshControl?.tintColor = .baisc
        $0.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.rowHeight = UITableView.automaticDimension
        $0.register(RepositoriesTableViewCell.self, forCellReuseIdentifier: RepositoriesTableViewCell.identifier)
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - setup
extension RepositoriesView {
    func setupViews() {
        addAutoLayoutSubViews([tableView])
        
        tableView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
    }
}
