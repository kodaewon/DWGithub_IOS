//
//  FollowViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/19.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class FollowViewController: BaseViewController {
    
    // MARK: - view properties
    private let followView = FollowView()
    
    private var tableView: UITableView { return followView.tableView }

    // MARK: - properties
    let viewModel = FollowViewModel()
    
    var requestURLString: String = ""
    
    // MARK: - life cycle
    override func loadView() {
        view = followView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        
        bind()
    }
}

// MARK: - binds
extension FollowViewController {
    func bind() {
        Observable<String>.of(requestURLString)
            .bind(to: viewModel.fetchFollow)
            .disposed(by: disposeBag)
        
        viewModel.followers
            .bind(to: tableView.rx.items(cellIdentifier: FollowTableViewCell.identifier, cellType: FollowTableViewCell.self)) { index, item, cell in
                cell.update(item)
            }
            .disposed(by: disposeBag)
    }
}
