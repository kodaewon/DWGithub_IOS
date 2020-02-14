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
        imageView.backgroundColor = .red
        return imageView
    }()
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .text
        label.text = ""
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .text
        label.text = ""
        return label
    }()
    
    let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let starGazersCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.textColor = .text
        label.text = ""
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.text = ""
        return label
    }()
    
    // MARK: - properties
    static let identifier = "SearchTableViewCell"
    
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

// MARK: - setup
extension SearchTableViewCell {
    func setupViews() {
        addAutoLayoutSubViews([repoIconImageView, fullNameLabel, descriptionLabel, starImageView, starGazersCountLabel, languageLabel])
        
        repoIconImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(12)
            $0.left.equalToSuperview().offset(16)
        }
        
        fullNameLabel.snp.makeConstraints {
            $0.left.equalTo(repoIconImageView.snp.right).offset(8)
            $0.right.equalToSuperview().offset(-8)
            $0.centerY.equalTo(repoIconImageView.snp.centerY)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(16)
            $0.left.equalTo(fullNameLabel.snp.left)
            $0.right.equalTo(fullNameLabel.snp.right)
            $0.top.equalTo(repoIconImageView.snp.bottom).offset(8)
        }
        
        starImageView.snp.makeConstraints {
            $0.width.height.equalTo(18)
            $0.left.equalTo(descriptionLabel.snp.left)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        starGazersCountLabel.snp.makeConstraints {
            $0.left.equalTo(starImageView.snp.right).offset(4)
            $0.centerY.equalTo(starImageView.snp.centerY)
        }
        
        languageLabel.snp.makeConstraints {
            $0.left.equalTo(starGazersCountLabel.snp.right).offset(8)
            $0.centerY.equalTo(starGazersCountLabel.snp.centerY)
        }
    }
}
