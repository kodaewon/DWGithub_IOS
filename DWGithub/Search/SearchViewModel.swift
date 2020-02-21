//
//  SearchViewModel.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/05.
//  Copyright © 2020 고대원. All rights reserved.
//

import RxSwift

protocol SearchViewModelType {
    var fetchRepositoies: AnyObserver<Void> { get }
    var searchTextChange: AnyObserver<String> { get }
    var tableViewWillDisplayCell: AnyObserver<IndexPath> { get }
    var selectTableView: AnyObserver<IndexPath> { get }
    
    var searchModel: Observable<(model: SearchModel, inc: Int)> { get }
    var actived: Observable<Bool> { get }
    var allRepositories: Observable<[RepositoriesItem]> { get }
    var repoDetailOpen: Observable<String> { get }
}

class SearchViewModel: SearchViewModelType {
    
    var disposeBag = DisposeBag()
    
    var fetchRepositoies: AnyObserver<Void>
    var searchTextChange: AnyObserver<String>
    var tableViewWillDisplayCell: AnyObserver<IndexPath>
    var selectTableView: AnyObserver<IndexPath>
    
    var searchModel: Observable<(model: SearchModel, inc: Int)>
    var actived: Observable<Bool>
    var allRepositories: Observable<[RepositoriesItem]>
    var repoDetailOpen: Observable<String>
    
    init(_ domain: GitHubService = GitHubService()) {
        let fetching = PublishSubject<Void>()
        let searchText = PublishSubject<String>()
        let willDisplayCell = PublishSubject<IndexPath>()
        let select = PublishSubject<IndexPath>()
        
        let search = BehaviorSubject<(model: SearchModel, inc: Int)>(value: (model: SearchModel(), inc: 0))
        let activing = BehaviorSubject<Bool>(value: false)
        let allRepo = BehaviorSubject<[RepositoriesItem]>(value: [])
        let repoOpen = PublishSubject<String>()
            
        fetchRepositoies = fetching.asObserver()
        searchTextChange = searchText.asObserver()
        tableViewWillDisplayCell = willDisplayCell.asObserver()
        selectTableView = select.asObserver()
        
        fetching
            .map { (model: SearchModel(q: "", page: 1, items: []), inc : 0) }
            .subscribe(onNext: search.onNext)
            .disposed(by: disposeBag)
        
        searchText
            .distinctUntilChanged()
            .map { (model: SearchModel(q: $0, page: 1, items: []), inc : 0) }
            .subscribe(onNext: search.onNext)
            .disposed(by: disposeBag)

        willDisplayCell
            .withLatestFrom(allRepo) { (update, origin) -> Any in
                if (origin.count - 2) < update.row {
                    return true
                }
                return false
            }
            .withLatestFrom(search) { (update, origin) -> Any in
                if let updateVale = update as? Bool, updateVale {
                    return (model: origin.model, inc: 1)
                }
                return false
            }
            .subscribe(onNext: { data in
                if let model = data as? (model: SearchModel, inc: Int) {
                    search.onNext(model)
                }
            })
            .disposed(by: disposeBag)
        
        select
            .withLatestFrom(allRepo) { (indexPath, repos) -> String in
                return repos[indexPath.row].html_url
            }
            .subscribe(onNext: repoOpen.onNext)
            .disposed(by: disposeBag)
        
        searchModel = search.asObserver()
        actived = activing.asObservable()
        allRepositories = allRepo.asObserver()
        repoDetailOpen = repoOpen.asObserver()
        
        search
            .do(onNext: { _ in activing.onNext(false) })
            .flatMap { domain.repositories(q: $0.model.q, page: $0.model.page + $0.inc) }
            .do(onNext: { _ in activing.onNext(true) })
            .withLatestFrom(allRepo) { (update, origin) -> [RepositoriesItem] in
                return origin + update.items
            }
            .subscribe(onNext: allRepo.onNext)
            .disposed(by: disposeBag)
        
    }
}
