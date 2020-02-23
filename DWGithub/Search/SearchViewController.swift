//
//  SearchViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit
import SafariServices

import RxCocoa
import RxSwift

class SearchViewController: BaseViewController {
    
    // MARK: - view properties
    private let searchViewController = UISearchController(searchResultsController: nil)
    
    private var searchView: SearchView { return view as! SearchView }
    
    private var tableView: UITableView { return searchView.tableView }
    
    // MARK: - properties
    let viewModel = SearchViewModel()
    
    var page: Int = 1
    
    // MARK: - life cycle
    override func loadView() {
        view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchViewController.searchResultsUpdater = self
        searchViewController.hidesNavigationBarDuringPresentation = true
        searchViewController.obscuresBackgroundDuringPresentation = false
        
        setupNavigation()
        
        binds()
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

// MARK: - bind
extension SearchViewController {
    func binds() {
// FIXME: - 당겨서 새로고침시에 끝나면 네비게이션바가 라지로 되지 않음
//        let reload = tableView.refreshControl?.rx
//            .controlEvent(.valueChanged)
//            .map { _ in () } ?? Observable.just(())
//
//        Observable.merge([reload])
//            .flatMap { Observable<(q: String, page: Int)>.just((q: "a", page: 1)) }
//            .bind(to: viewModel.fetchRepositoies)
//            .disposed(by: disposeBag)
        
        // Input
        Observable.just(())
            .bind(to: viewModel.fetchRepositoies)
            .disposed(by: disposeBag)
        
        searchViewController.searchBar.rx.searchButtonClicked
            .map { self.searchViewController.searchBar.text ?? "" }
            .bind(to: viewModel.searchTextChange )
            .disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell
            .map { $0.indexPath }
            .bind(to: viewModel.tableViewWillDisplayCell)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(to: viewModel.selectTableView)
            .disposed(by: disposeBag)
        
        // Output
        viewModel.actived
            .subscribe(onNext: { actived in
                if actived {
                    self.tableView.refreshControl?.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.allRepositories
            .subscribe(onNext: { repos in
                if !repos.isEmpty {
                    self.tableView.isHidden = false
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.allRepositories
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { index, item, cell in
                cell.fullNameLabel.text = item.full_name
                cell.descriptionLabel.text = item.name
                cell.starGazersCountLabel.text = "\(item.stargazers_count)"
                cell.languageImageView.image = UIImage(named: item.language.image)
                cell.languageLabel.text = item.language.description
            }
            .disposed(by: disposeBag)
        
        viewModel.repoDetailOpen
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { urlString in
                if let url = URL(string: urlString) {
                    let vc = SFSafariViewController(url: url)
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
        
    }
}

// MARK: - setup
extension SearchViewController {
    func setupNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationController?.navigationBar.barTintColor = .background
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.largeContentTitle = "Search".localized()
        }
        
        navigationItem.searchController = searchViewController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
}
