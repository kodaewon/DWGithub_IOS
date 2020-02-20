//
//  MyPageViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/18.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

class MyPageViewController: BaseViewController {
    
    // MARK: - view proerties
    private let myPageView = MyPageView()
    
    private var tableView: UITableView { return myPageView.tableView }
    
    // MARK: - properties
    private let userInfo = UserInfo.shared
    
    // MARK: - lifecycle
    override func loadView() {
        view = myPageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.title = "My Profile".localized()
        
        binds()
    }
}

// MARK: - bind
extension MyPageViewController {
    func binds() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfMyPageItem>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: indexPath) as! MyPageTableViewCell
                
                cell.titleLabel.text = item.title
                cell.descLabel.text = item.desc
                
                return cell
        })
        
        dataSource.titleForHeaderInSection = { datasource, index in
            return datasource.sectionModels[index].header
        }
        
        let sections = [
            SectionOfMyPageItem(header: "내 정보", items: [
                MyPageItem(title: "이름", desc: userInfo.name),
                MyPageItem(title: "이메일", desc: userInfo.email),
                MyPageItem(title: "소속", desc: userInfo.company),
                MyPageItem(title: "블로그", desc: userInfo.bio),
                MyPageItem(title: "URL", desc: "https://github.com/\(userInfo.login)")
            ])
        ]
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

// MARK: - mypage datasource
struct MyPageItem {
    var title: String
    var desc: String
}

struct SectionOfMyPageItem {
    var header: String
    var items: [MyPageItem]
}

extension SectionOfMyPageItem: SectionModelType {
    init(original: SectionOfMyPageItem, items: [MyPageItem]) {
        self = original
        self.items = items
    }
}
