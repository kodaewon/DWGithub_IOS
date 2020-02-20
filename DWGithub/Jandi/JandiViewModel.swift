//
//  JandiViewModel.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/20.
//  Copyright © 2020 고대원. All rights reserved.
//

import RxSwift

protocol JandiViewModelType {
    var fetchContribution: AnyObserver<String> { get }
    var fetchDetailContribution: AnyObserver<IndexPath> { get }
    
    var contributionStream: Observable<Contributions> { get }
    var contributionDetailStream: Observable<IndexPath> { get }
}

class JandiViewModel: JandiViewModelType {
    
    var disposeBag = DisposeBag()
    
    var fetchContribution: AnyObserver<String>
    var fetchDetailContribution: AnyObserver<IndexPath>
    
    var contributionStream: Observable<Contributions>
    var contributionDetailStream: Observable<IndexPath>
    
    init(_ domain: GitHubService = GitHubService()) {
        let fetch = PublishSubject<String>()
        let fetchDetail = PublishSubject<IndexPath>()
        
        let contribution = PublishSubject<Contributions>()
        var contributionDetail = PublishSubject<IndexPath>()
        
        fetchContribution = fetch.asObserver()
        fetchDetailContribution = fetchDetail.asObserver()
        
        fetch
            .flatMap { domain.contributions(username: $0) }
            .subscribe(onNext: contribution.onNext)
            .disposed(by: disposeBag)
        
        fetchDetail
            .distinctUntilChanged()
            .subscribe(onNext: contributionDetail.onNext)
            .disposed(by: disposeBag)
        
        contributionStream = contribution.asObserver()
        contributionDetailStream = contributionDetail.asObservable()
    }
}
