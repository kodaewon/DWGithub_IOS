//
//  RepositoriesViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import RxViewController

class RepositoriesViewController: BaseViewController {
    
    // MARK: - view properties
    private let repositoriesView = RepositoriesView()
    
    private var tableView: UITableView { return repositoriesView.tableView }
    
    // MARK: - properties
    let viewModel = RepositoriesViewModel()

    // MARK: - life cycle
    override func loadView() {
        view = repositoriesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()

        binds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: - bind
extension RepositoriesViewController {
    func binds() {
        let viewWillReload = rx.viewWillAppear
//            .take(1)
            .map { _ in () }
        
        Observable.merge([viewWillReload])
            .bind(to: viewModel.fetchRepositories)
            .disposed(by: disposeBag)
    
        viewModel.repositories
            .bind(to: tableView.rx.items(cellIdentifier: RepositoriesTableViewCell.identifier, cellType: RepositoriesTableViewCell.self)) { index, item, cell in
                
                cell.nameLabel.text = item.full_name
                cell.privateLabel.text = item.isPrivate ? "  Private  " : "  Public  "
                cell.descriptionLabel.text = item.description
                cell.forkLabel.text = item.fork ? item.forks_url : ""
                cell.starGazersCountLabel.text = "\(item.stargazers_count)"
                cell.languageImageView.image = UIImage(named: item.language.image)
                cell.languageLabel.text = item.language.description
                
            }.disposed(by: disposeBag)
    }
}

// MARK: - setup
extension RepositoriesViewController {
    func setupNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationController?.navigationBar.barTintColor = .background
        
        navigationItem.title = "Repositories".localized()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
}
