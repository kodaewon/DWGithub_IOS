//
//  JandiView.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import GoogleMobileAds
import Then
import SnapKit

class JandiView: UIView {
    
    // MARK: - view properties
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            let width = UIScreen.main.bounds.width
            layout.headerReferenceSize = CGSize(width: width, height: 40)
            layout.itemSize = CGSize(width: width, height: 145)
        }
        
        $0.backgroundColor = .groupBackground
        $0.bounces = true

        $0.register(JandiCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: JandiCollectionHeaderView.identifier)
        $0.register(JandiCollectionCell.self, forCellWithReuseIdentifier: JandiCollectionCell.identifier)
        $0.register(JandiDetailCollectionCell.self, forCellWithReuseIdentifier: JandiDetailCollectionCell.identifier)
    }
    
    let googleAdmobView = GADBannerView(adSize: kGADAdSizeBanner).then {
        $0.adUnitID = "ca-app-pub-8586866298429575/3000540349"
        #if DEBUG
        $0.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        #endif
        $0.isHidden = true
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setup
extension JandiView {
    func setupViews() {
        addAutoLayoutSubViews([collectionView, googleAdmobView])
        
        collectionView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(snp.topMargin)
        }
        
        googleAdmobView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(snp.bottomMargin)
        }
    }
}
