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
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return tableView
    }()
    
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
extension SearchView {
    func setupViews() {
        backgroundColor = .white
        
        addAutoLayoutSubViews([tableView])
        
        tableView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
    }
}
