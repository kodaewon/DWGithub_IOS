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
    
    var searchModel: Observable<(model: SearchModel, inc: Int)> { get }
    var actived: Observable<Bool> { get }
    var allRepositories: Observable<[RepositoriesItem]> { get }
}

class SearchViewModel: SearchViewModelType {
    
    var disposeBag = DisposeBag()
    
    var fetchRepositoies: AnyObserver<Void>
    var searchTextChange: AnyObserver<String>
    var tableViewWillDisplayCell: AnyObserver<IndexPath>
    
    var searchModel: Observable<(model: SearchModel, inc: Int)>
    var actived: Observable<Bool>
    var allRepositories: Observable<[RepositoriesItem]>
    
    init(_ domain: GitHubService = GitHubService()) {
        let fetching = PublishSubject<Void>()
        let searchText = PublishSubject<String>()
        let willDisplayCell = PublishSubject<IndexPath>()
        
        let model = BehaviorSubject<(model: SearchModel, inc: Int)>(value: (model: SearchModel(), inc: 0))
        let activing = BehaviorSubject<Bool>(value: false)
        let allRepo = BehaviorSubject<[RepositoriesItem]>(value: [])
            
        fetchRepositoies = fetching.asObserver()
        searchTextChange = searchText.asObserver()
        tableViewWillDisplayCell = willDisplayCell.asObserver()
        
        fetching
            .do(onNext: { _ in activing.onNext(false) })
            .flatMap { domain.repositories(q: "", page: 1) }
            .do(onNext: { _ in activing.onNext(true) })
            .map { (model: SearchModel(q: "", page: 1, items: $0.items), inc : 0) }
            .subscribe(onNext: model.onNext)
            .disposed(by: disposeBag)
        
        searchText
            .distinctUntilChanged()
            .do(onNext: { _ in activing.onNext(false) })
            .flatMap { domain.repositories(q: $0, page: 1) }
            .do(onNext: { _ in activing.onNext(true) })
            .map { (model: SearchModel(q: "", page: 1, items: $0.items), inc : 0) }
            .subscribe(onNext: model.onNext)
            .disposed(by: disposeBag)
            
        
        searchModel = model.asObserver()
        actived = activing.asObservable()
        allRepositories = allRepo.asObserver()
    
        model
            .map { $0.model.items }
            .subscribe(onNext: allRepo.onNext)
            .disposed(by: disposeBag)
    }
}
