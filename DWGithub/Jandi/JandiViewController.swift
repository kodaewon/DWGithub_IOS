//
//  JandiViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import GoogleMobileAds
import RxCocoa
import RxDataSources
import RxSwift
class JandiViewController: BaseViewController {
    
    // MARK: - view properties
    let jandiView = JandiView()
    
    private var collectionView: UICollectionView { return jandiView.collectionView }
    private var googleAdmobView: GADBannerView { return jandiView.googleAdmobView }
    
    // MARK: - properties
    let viewModel = JandiViewModel()
    
    let userInfo = UserInfo.shared
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfJadiItem>!
    var sections: BehaviorRelay<[SectionOfJadiItem]> = BehaviorRelay(value: [])
    
    // MARK: - life cycle
    override func loadView() {
        view = jandiView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigation()
        
        setupCollectionView()
        
        bind()
        
        googleAdmobView.delegate = self
        googleAdmobView.rootViewController = self
        googleAdmobView.load(GADRequest())
    }
}

// MARK: -
extension JandiViewController: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("adViewDidReceiveAd")
        googleAdmobView.isHidden = false
        googleAdmobView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.googleAdmobView.alpha = 1
        })
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
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
                let sectionOfItem = SectionOfJadiItem(header: "My Contribution".localized(), items: [
                    JandiItem(title: "a", item: nil, items: data)
                ])
                self.sections.accept([sectionOfItem])
            })
            .disposed(by: disposeBag)
        
        viewModel.contributionDetailStream
            .subscribe(onNext: { item in
                let sectionOfItem = SectionOfJadiItem(header: "My Contribution Detail".localized(), items: [
                    JandiItem(title: "b", item: item, items: [])
                ])
                var sectionValue = self.sections.value
                if sectionValue.count > 1 {
                    sectionValue[1] = sectionOfItem
                } else {
                    sectionValue.append(sectionOfItem)
                }
                
                self.sections.accept(sectionValue)
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
        
        sections
            .asObservable()
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
