//
//  JandiContributionCollectionCell.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/20.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

class JandiContributionCollectionCell: UICollectionViewCell {
    
    // MARK: - properties
    static let identifier = "JandiContributionCollectionCell"
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
