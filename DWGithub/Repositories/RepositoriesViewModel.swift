//
//  RepositoriesViewModel.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/11.
//  Copyright © 2020 고대원. All rights reserved.
//

import RxSwift

protocol RepositoriesViewModelType {
    var fetchRepositories: AnyObserver<Void> { get }
    var selectTableView: AnyObserver<IndexPath> { get }
    
    var searchUserName: Observable<Void> { get }
    var repositories: Observable<[RepositoriesItem]> { get }
    var errors: Observable<Error> { get }
    var repoDetailOpen: Observable<String> { get }
}

class RepositoriesViewModel: RepositoriesViewModelType {
    
    var disposeBag = DisposeBag()
    
    var fetchRepositories: AnyObserver<Void>
    var selectTableView: AnyObserver<IndexPath>
    
    var searchUserName: Observable<Void>
    var repositories: Observable<[RepositoriesItem]>
    var errors: Observable<Error>
    var repoDetailOpen: Observable<String>
    
    init(domain: GitHubService = GitHubService(), userInfo: UserInfo = UserInfo.shared) {
        let fetch = PublishSubject<Void>()
        let select = PublishSubject<IndexPath>()
        
        let search = PublishSubject<Void>()
        let repo = BehaviorSubject<[RepositoriesItem]>(value: [])
        let error = PublishSubject<Error>()
        let repoOpen = PublishSubject<String>()
        
        // INPUT
        fetchRepositories = fetch.asObserver()
        selectTableView = select.asObserver()
        
        fetch
            .subscribe(onNext: {
                search.onNext(())
            })
            .disposed(by: disposeBag)
        
        select
            .withLatestFrom(repo) { (indexPath, repos) -> String in
                return repos[indexPath.row].html_url
            }
            .subscribe(onNext: repoOpen.onNext)
            .disposed(by: disposeBag)
        
        // OUTPUT
        searchUserName = search.asObserver()
        repositories = repo.asObserver()
        errors = error.asObserver()
        repoDetailOpen = repoOpen.asObserver()
        
        search
            .flatMap { domain.authRepositories(token: userInfo.token) }
            .subscribe(onNext: repo.onNext)
            .disposed(by: disposeBag)
    }
}
