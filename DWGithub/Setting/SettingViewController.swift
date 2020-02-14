//
//  SettingViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

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
    
    // MARK: - lifecycle
    override func loadView() {
        view = settingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        
        binds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let url = URL(string: userInfo.avatar_url)
        profileImageView.kf.setImage(with: url)
    }
}

// MARK: - bind
extension SettingViewController {
    func binds() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfSettingItem>(configureCell: { datasource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
            cell.textLabel?.text = item.title
            cell.update(item.type)
            return cell
        })
        
        dataSource.titleForHeaderInSection = { datasource, index in
            return datasource.sectionModels[index].header
        }
        
        let sections = [
            SectionOfSettingItem(header: "설정", items: [SettingItem(title: "테마", type: .info), SettingItem(title: "다크모드", type: .toggle)]),
            SectionOfSettingItem(header: "서비스 지원", items: [SettingItem(title: "버전 정보", type: .info), SettingItem(title: "라이센스", type: .normal)]),
            SectionOfSettingItem(header: " ", items: [SettingItem(title: "로그아웃", type: .normal)])
        ]
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    
        // OUTPUT
        profileButton.rx.tap
            .subscribe(onNext: {
                
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                if indexPath.section == 2 {
                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                        let nc = appDelegate.window?.rootViewController as? UINavigationController {
                        let vc = LoginViewController()
                        nc.setViewControllers([vc], animated: false)
                    }
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
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.title = "My Profile"
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.largeContentTitle = "My Profile"
        }
        
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
