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
                    item.item = data
                    section.items[0] = item
                    self.sections[0] = section
                }
                
                Observable.just(self.sections)
                    .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        viewModel.contributionDetailStream
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { indexPath in
                print("indexPath = \(indexPath)")
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - setup
extension JandiViewController {
    func setupCollectionView() {
        dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfJadiItem>(configureCell: { dataSource, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JandiCollectionCell.identifier, for: indexPath) as! JandiCollectionCell
            cell.update(item.item)
            cell.collectionView.rx.itemSelected
                .bind(to: self.viewModel.fetchDetailContribution)
                .disposed(by: cell.disposeBag)
            return cell
        })
        
        dataSource.configureSupplementaryView = { (dataSource, collectionView, element, indexPath) in
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: JandiCollectionHeaderView.identifier, for: indexPath) as!  JandiCollectionHeaderView
            view.titleLabel.text = dataSource[indexPath.section].header
            return view
        }
        
        sections = [
            SectionOfJadiItem(header: "My", items: [
                JandiItem(title: "a", item: Contributions())
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
