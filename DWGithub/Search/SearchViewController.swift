//
//  SearchViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class SearchViewController: UIViewController {
    
    // MARK: - view properties
    private var searchView: SearchView { return view as! SearchView }
    
    private var tableView: UITableView { return searchView.tableView }
    
    private let searchViewController = UISearchController(searchResultsController: nil)
    
    // MARK: - properties
    
    var disposBag = DisposeBag()
    
    override func loadView() {
        view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.largeContentTitle = "Search"
        }
        
        navigationItem.searchController = searchViewController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchViewController.searchResultsUpdater = self
        searchViewController.hidesNavigationBarDuringPresentation = true
        searchViewController.obscuresBackgroundDuringPresentation = false
        searchViewController.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        disposBag = DisposeBag()
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

// MARK: - UISearchControllerDelegate
extension SearchViewController: UISearchControllerDelegate {
    
}

// MARK: - bind
extension SearchViewController {
    func binds() {
        
    }
}

// MARK: - init
extension SearchViewController {
    func naviInit() {
        
    }
}
