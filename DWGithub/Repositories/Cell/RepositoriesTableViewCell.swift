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
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    
    let nameLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
        $0.font = .bold(21)
        $0.textColor = .text
        $0.text = ""
    }
    
    let privateView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let privateLabel = UILabel().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
        $0.backgroundColor = .white
        $0.numberOfLines = 1
        $0.lineBreakMode = .byWordWrapping
        $0.font = .light(13)
        $0.textColor = .black
        $0.text = ""
    }
    
    let forkLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = .regular(15)
        $0.textColor = .text
        $0.text = ""
    }
    
    let descriptionLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.lineBreakMode = .byWordWrapping
        $0.font = .regular(17)
        $0.textColor = .text
        $0.text = ""
    }
    
    let starImageView = UIImageView().then {
        $0.image = UIImage(named: "star")
    }
    
    let starGazersCountLabel = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.lineBreakMode = .byWordWrapping
        $0.font = .regular(13)
        $0.textColor = .text
        $0.text = ""
    }
    
    let languageImageView = UIImageView().then {
        $0.image = UIImage(named: "search")
    }
    
    let languageLabel = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.lineBreakMode = .byWordWrapping
        $0.font = .regular(13)
        $0.textColor = .text
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
        addAutoLayoutSubViews([verticalStackView, forkLabel, descriptionLabel, starImageView, starGazersCountLabel, languageImageView, languageLabel])
        
        verticalStackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(8)
        }
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(privateView)
        
        privateView.snp.makeConstraints {
            $0.width.equalTo(50)
        }
        
        privateView.addAutoLayoutSubViews([privateLabel])
        privateLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.left.top.equalToSuperview()
        }
        
        forkLabel.snp.makeConstraints {
            $0.left.equalTo(verticalStackView.snp.left)
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalTo(verticalStackView.snp.bottom).offset(6)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.left.equalTo(forkLabel.snp.left)
            $0.right.equalToSuperview().offset(16)
            $0.top.equalTo(forkLabel.snp.bottom).offset(6)
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
        
        languageImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.left.equalTo(starGazersCountLabel.snp.right).offset(8)
            $0.centerY.equalTo(starImageView.snp.centerY)
        }
        
        languageLabel.snp.makeConstraints {
            $0.left.equalTo(languageImageView.snp.right).offset(4)
            $0.centerY.equalTo(starImageView.snp.centerY)
        }
    }
}
