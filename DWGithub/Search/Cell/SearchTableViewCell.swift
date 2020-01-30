//
//  SearchTableViewCell.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/30.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import SnapKit

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - view properties
    let repoIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView.image = UIImageAsse
        return imageView
    }()
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let startImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let stargazersCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setup
extension SearchTableViewCell {
    func setupViews() {
        addAutoLayoutSubViews([repoIconImageView, fullNameLabel, descriptionLabel, startImageView, stargazersCountLabel, languageLabel])
        
        repoIconImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(8)
            $0.left.equalToSuperview().offset(16)
        }
        
        fullNameLabel.snp.makeConstraints {
            $0.left.equalTo(repoIconImageView.snp.right).offset(-8)
            $0.centerY.equalTo(repoIconImageView.snp.centerY)
        }
    }
}
