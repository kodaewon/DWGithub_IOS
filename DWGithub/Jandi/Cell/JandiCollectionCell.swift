//
//  JandiCollectionCell.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/20.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import Then
import SnapKit

class JandiCollectionCell: UICollectionViewCell {
    
    // MARK: - view properties
    let indicatorView = UIActivityIndicatorView().then {
        $0.color = .baisc
        $0.isHidden = true
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 4
            layout.minimumLineSpacing = 4
            layout.itemSize = CGSize(width: 16, height: 16)
            $0.collectionViewLayout = layout
        }
        
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        $0.backgroundColor = .white
        $0.bounces = false
        $0.isHidden = false
        
        $0.register(JandiContributionCollectionCell.self, forCellWithReuseIdentifier: JandiContributionCollectionCell.identifier)
    }
    
    // MARK: - properties
    var disposeBag = DisposeBag()
    
    var items: [ParsingContribution] = []
    
    static let identifier = "JandiCollectionCell"
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupView()
        
        initCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    // MARK: - update
    func update(_ items: [ParsingContribution]) {
        self.items = items
//        items.reverse()
        collectionView.reloadData()
    }
}

// MARK: - collectionView
extension JandiCollectionCell {
    func initCollectionView() {
        collectionView.dataSource = self
    }
}

extension JandiCollectionCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count > 0 ? items.count : 365
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JandiContributionCollectionCell.identifier, for: indexPath) as! JandiContributionCollectionCell
        
        if items.count > 0 {
            let item = items[indexPath.row]
            cell.backgroundColor = UIColor(hexString: item.color)
        }
        
        return cell
    }
}

// MARK: - setup
extension JandiCollectionCell {
    func setupView() {
        addAutoLayoutSubViews([indicatorView, collectionView])
        
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
}
