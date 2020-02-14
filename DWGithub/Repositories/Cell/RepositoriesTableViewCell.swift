//
//  RepositoriesTableViewCell.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/10.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import SnapKit
import Then

class RepositoriesTableViewCell: UITableViewCell {
    // MARK: - view properties
    let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
    }
    
    let nameLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
        $0.textColor = .text
        $0.text = ""
    }
    
    let privateLabel = UILabel().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .white
        $0.numberOfLines = 1
        $0.lineBreakMode = .byWordWrapping
        $0.textColor = .text
        $0.text = ""
    }
    
    let forkLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.textColor = .text
        $0.text = ""
    }
    
    let descriptionLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.lineBreakMode = .byWordWrapping
        $0.textColor = .text
        $0.text = ""
    }
    
    let starImageView = UIImageView().then {
        $0.backgroundColor = .blue
    }
    
    let starGazersCountLabel = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.lineBreakMode = .byWordWrapping
        $0.textColor = .text
        $0.text = ""
    }
    
    let languageLabel = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.lineBreakMode = .byWordWrapping
        $0.text = ""
    }
    
    // MARK: - properties
    static let identifier = "RepositoriesTableViewCell"
    
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
extension RepositoriesTableViewCell {
    func setupViews() {
        addAutoLayoutSubViews([verticalStackView, nameLabel, privateLabel, forkLabel, descriptionLabel, starImageView, starGazersCountLabel, languageLabel])

        nameLabel.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.left.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(8)
        }

        privateLabel.snp.makeConstraints {
            $0.left.equalTo(nameLabel.snp.right).offset(8)
//            $0.right.equalToSuperview().offset(16)
            $0.centerY.equalTo(nameLabel.snp.centerY)
        }
        
        forkLabel.snp.makeConstraints {
            $0.left.equalTo(nameLabel.snp.left)
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.left.equalTo(nameLabel.snp.left)
            $0.right.equalToSuperview().offset(16)
            $0.top.equalTo(forkLabel.snp.bottom).offset(4)
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
