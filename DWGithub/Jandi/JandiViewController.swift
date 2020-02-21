//
//  JandiViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

class JandiViewController: BaseViewController {
    
    // MARK: - view properties
    let jandiView = JandiView()
    
    private var collectionView: UICollectionView { return jandiView.collectionView }
    
    // MARK: - properties
    let viewModel = JandiViewModel()
    
    let userInfo = UserInfo.shared
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfJadiItem>!
    var sections: [SectionOfJadiItem] = []
    
    // MARK: - life cycle
    override func loadView() {
        view = jandiView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigation()
        
        setupCollectionView()
        
        bind()
    }
}

// MARK: - bind
extension JandiViewController {
    func bind() {
        Observable<String>.of(userInfo.login)
            .bind(to: viewModel.fetchContribution)
            .disposed(by: disposeBag)
        
        viewModel.contributionStream
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { data in
                if var section = self.sections.first, var item = section.items.first {
                    item.items = data
                    section.items[0] = item
                    self.sections[0] = section
                }
                
                Observable.just(self.sections)
                    .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        viewModel.contributionDetailStream
            .subscribe(onNext: { item in
                let sectionOfItem = SectionOfJadiItem(header: "My Contribution Detail".localized(), items: [
                    JandiItem(title: "b", item: item, items: [])
                ])
                
                if self.sections.count > 1 {
                    self.sections[1] = sectionOfItem
                } else {
                    self.sections.append(sectionOfItem)
                }
                
                Observable.just(self.sections)
                    .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - setup
extension JandiViewController {
    func setupCollectionView() {
        dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfJadiItem>(configureCell: { dataSource, collectionView, indexPath, item in
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JandiCollectionCell.identifier, for: indexPath) as! JandiCollectionCell
                cell.update(item.items)
                cell.collectionView.rx.itemSelected
                    .bind(to: self.viewModel.fetchDetailContribution)
                    .disposed(by: cell.disposeBag)
                return cell
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JandiDetailCollectionCell.identifier, for: indexPath) as! JandiDetailCollectionCell
            if let item = item.item {
                cell.dateLabel.text = "DATE : \(item.date)"
                cell.countLabel.text = "COUNT : \(item.count)"
            }
            return cell
        })
        
        dataSource.configureSupplementaryView = { (dataSource, collectionView, element, indexPath) in
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: JandiCollectionHeaderView.identifier, for: indexPath) as!  JandiCollectionHeaderView
            view.titleLabel.text = dataSource[indexPath.section].header
            return view
        }
        
        sections = [
            SectionOfJadiItem(header: "My Contribution".localized(), items: [
                JandiItem(title: "a", item: nil, items: [])
            ])
        ]
        
        Observable.just(sections)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func initNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationController?.navigationBar.barTintColor = .background
        
        navigationItem.title = "Jandi".localized()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
}
