//
//  FollowTableViewCell.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/20.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import Then
import SnapKit

class FollowTableViewCell: UITableViewCell {
    
    // MARK: - view properties
    let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 24
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .lightGray
    }
    
    let nameLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
        $0.textColor = .text
        $0.text = ""
    }
    
    // MARK: - properties
    static let identifier = "FollowTableViewCell"
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    func update(_ item: FollowModel) {
        if let url = URL(string: item.avatar_url) {
            profileImageView.kf.setImage(with: url)
        }
        
        nameLabel.text = item.login
    }
}

// MARK: - setupViews
extension FollowTableViewCell {
    func setupViews() {
        addAutoLayoutSubViews([profileImageView, nameLabel])
        
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.top.equalToSuperview().offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.left.equalTo(profileImageView.snp.right).offset(12)
        }
    }
}
