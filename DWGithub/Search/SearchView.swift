//
//  SearchView.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import SnapKit

class SearchView: UIView {
    // MARK: - view properties
    let emtpyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .text
        label.text = "검색 정보가 없습니다\n저장소 이름을 검색해 주세요"
        label.isHidden = true
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
//        tableView.refreshControl = UIRefreshControl()
//        tableView.refreshControl?.tintColor = .baisc
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
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
extension SearchView {
    func setupViews() {
        addAutoLayoutSubViews([tableView])
        
        tableView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(snp.topMargin)
        }
        
        tableView.addAutoLayoutSubViews([emtpyLabel])
        
        emtpyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
