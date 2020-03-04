//
//  SettingViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit

import Kingfisher
import RxDataSources
import RxSwift
import SnapKit

class SettingViewController: BaseViewController {
    
    // MARK: - view proerties
    private let profileButton = UIButton()
    private let profileImageView = UIImageView()
    
    private let settingView = SettingView()
    
    private var tableView: UITableView { return settingView.tableView }
    
    // MARK: - properties
    private let userInfo = UserInfo.shared
    
    private var productsRequest: SKProductsRequest?
    private let productIdentifiers: Set<String> = ["com.kodaewon.DWGitHub.coffeAdrink"]
    
    // MARK: - lifecycle
    override func loadView() {
        view = settingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        
        binds()
        
        if SKPaymentQueue.canMakePayments() {
            print("된다")
            productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
            productsRequest?.delegate = self
            productsRequest?.start()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let url = URL(string: userInfo.avatar_url)
        profileImageView.kf.setImage(with: url)
        
        profileButton.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        profileButton.isHidden = true
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension SettingViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
}

// MARK: - SKProductsRequestDelegate
extension SettingViewController: SKProductsRequestDelegate {
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
       let products = response.products

       for p in products {
         print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
       }
     }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Found Error: \(error.localizedDescription)")
    }
}

// MARK: - bind
extension SettingViewController {
    func binds() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfSettingItem>(configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
            cell.titleLabel.text = item.title
            cell.infoLabel.text = item.info
            cell.update(item.type)
            return cell
        })
        
        dataSource.titleForHeaderInSection = { datasource, index in
            return datasource.sectionModels[index].header
        }
        
        var sections = [
            SectionOfSettingItem(header: "Favorites".localized(), items: [
                SettingItem(title: "Followers".localized(), info: "", type: .normal),
                SettingItem(title: "Following".localized(), info: "", type: .normal)
            ]),
            SectionOfSettingItem(header: "Support".localized(), items: [
                SettingItem(title: "Coffe a Drink".localized(), info: "", type: .normal)
            ]),
            SectionOfSettingItem(header: "Service support".localized(), items: [
                SettingItem(title: "Version information".localized(),
                            info: AppServiceUtils.versionInfo().0, type: .info),
                SettingItem(title: "License".localized(), info: "", type: .normal),
                SettingItem(title: "Contact us".localized(), info: "", type: .normal)
            ]),
            SectionOfSettingItem(header: " ", items: [
                SettingItem(title: "LogOut".localized(), info: "", type: .info)
            ])
        ]
        
        if #available(iOS 13.0, *) {
            sections.insert(
                SectionOfSettingItem(header: "Setting".localized(), items: [
//                SettingItem(title: "테마", type: .info),
                    SettingItem(title: "Dark Mode".localized(), info: (UIApplication.shared.delegate as! AppDelegate).window!.overrideUserInterfaceStyle.description.localized(), type: .info)
                            ]),
                at: 1)
        }
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    
        // OUTPUT
        profileButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.navigationController?.pushViewController(MyPageViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { indexPath in
                if indexPath.section == 0 {
                    let vc = FollowViewController()
                    vc.title = indexPath.row == 0 ? "팔로워" : "팔로윙"
                    vc.requestURLString = indexPath.row == 0 ? self.userInfo.followers_url : self.userInfo.requestFollowingURL
                    self.navigationController?.pushViewController(vc, animated: true)
                } else if indexPath.section == 1 {
                    if #available(iOS 13.0, *) {
                        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                        for (title, type) in
                            [("Light Mode".localized(), UIUserInterfaceStyle.light),
                             ("Dark Mode".localized(), UIUserInterfaceStyle.dark),
                             ("System Mode".localized(), UIUserInterfaceStyle.unspecified)] {
                                
                                let action = UIAlertAction(title: title, style: .default) { (action) in
                                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                                        appDelegate.window?.overrideUserInterfaceStyle = type
                                        UserDefaults.standard.set(title, forKey: USER_INTERFACEMODE)
                                        UserDefaults.standard.synchronize()
                                    }
                                    
                                    if let cell = self.tableView.cellForRow(at: indexPath) as? SettingTableViewCell {
                                        cell.infoLabel.text = type.description
                                    }
                                }
                                                
                                alert.addAction(action)
                        }
                        
                        let close = UIAlertAction(title: "Close".localized(), style: .cancel) { (action) in
                            alert.dismiss(animated: true, completion: nil)
                        }
                        alert.addAction(close)
                        
                        alert.show(self, sender: nil)
                        
                        DispatchQueue.main.async(execute: {
                            self.present(alert, animated: true, completion: nil)
                        })
                    }
                } else if indexPath.section == 2 {
                    if indexPath.row == 0 {
                        print("후원하기")
                    }
                } else if indexPath.section == 3 {
                    if indexPath.row == 0 {
                        AppServiceUtils.versionUpdate(false)
                    } else if indexPath.row == 1 {
                        AppServiceUtils.goSetting()
                    } else if indexPath.row == 2 {
                        let vc = MFMailComposeViewController()
                        vc.mailComposeDelegate = self
                        vc.setToRecipients(["dev.kodaewon@gmail.com"])
                        vc.setSubject("나만의 깃헙 문의하기")
                        let message = "\n\nOS Version : \(Constants.osVersion)\nApp Version : \(Constants.appVersion)"
                        vc.setMessageBody(message, isHTML: false)
                        if MFMailComposeViewController.canSendMail() {
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                } else if indexPath.section == 4 {
                    UIAlertController.confirm(parentVC: self, title: "", message: "LogOut?".localized(), okAction: {
                        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                            let nc = appDelegate.window?.rootViewController as? UINavigationController {
                            let vc = LoginViewController()
                            nc.setViewControllers([vc], animated: false)
                        }
                    }, cancelAction: nil)
                }
                
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - setup
extension SettingViewController {
    func setupNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.barTintColor = .background
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "Setting".localized()
//        if #available(iOS 13.0, *) {
//            navigationController?.navigationBar.largeContentTitle = "My Profile"
//        }
        
        profileButton.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 16
        profileImageView.clipsToBounds = true
        profileImageView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        navigationController?.navigationBar.addSubview(profileButton)
        profileButton.layer.zPosition = -1
        profileButton.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
}

// MARK: - setting datasource
struct SettingItem {
    var title: String
    var info: String
    var type: SettingTableViewCellType
}

struct SectionOfSettingItem {
    var header: String
    var items: [SettingItem]
}

extension SectionOfSettingItem: SectionModelType {
    init(original: SectionOfSettingItem, items: [SettingItem]) {
        self = original
        self.items = items
    }
}
