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
    
    var searchUserName: Observable<Void> { get }
    var repositories: Observable<[RepositoriesItem]> { get }
    var errors: Observable<Error> { get }
}

class RepositoriesViewModel: RepositoriesViewModelType {
    
    var disposeBag = DisposeBag()
    
    var fetchRepositories: AnyObserver<Void>
    
    var searchUserName: Observable<Void>
    var repositories: Observable<[RepositoriesItem]>
    var errors: Observable<Error>
    
    init(domain: GitHubService = GitHubService(), userInfo: UserInfo = UserInfo.shared) {
        let fetch = PublishSubject<Void>()
        
        let search = PublishSubject<Void>()
        let repo = BehaviorSubject<[RepositoriesItem]>(value: [])
        let error = PublishSubject<Error>()
        
        // INPUT
        fetchRepositories = fetch.asObserver()
        
        fetch
            .debug()
            .subscribe(onNext: {
                search.onNext(())
            })
            .disposed(by: disposeBag)
        
        // OUTPUT
        searchUserName = search.asObserver()
        repositories = repo.asObserver()
        errors = error.asObserver()
        
        search
            .flatMap { domain.authRepositories(token: userInfo.token) }
            .subscribe(onNext: repo.onNext)
            .disposed(by: disposeBag)
    }
}
