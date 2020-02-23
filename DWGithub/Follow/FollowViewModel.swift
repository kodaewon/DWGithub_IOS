//
//  FollowViewModel.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/19.
//  Copyright © 2020 고대원. All rights reserved.
//

import RxSwift

class FollowViewModel {
    
    var disposeBag = DisposeBag()
    
    var fetchFollow: AnyObserver<String>
    var tableViewSelect: AnyObserver<IndexPath>
    
    var followers: Observable<[FollowModel]>
    var userInfoOpen: Observable<String>
    
    init(domain: AppService = AppService()) {
        let fetch = PublishSubject<String>()
        let select = PublishSubject<IndexPath>()
        
        let follow = PublishSubject<[FollowModel]>()
        let infoOpen = PublishSubject<String>()
        
        fetchFollow = fetch.asObserver()
        tableViewSelect = select.asObserver()
        
        fetch
            .distinctUntilChanged()
            .flatMap { domain.rx_getRequest(urlString: $0) }
            .flatMap { (data) -> Observable<[FollowModel]> in
                return Observable<[FollowModel]>.create { observables in
                    if let followData = try? JSONDecoder().decode([FollowModel].self, from: data) {
                        observables.onNext(followData)
                    } else {
                        observables.onError(NSError(domain: "", code: 403, userInfo: nil))
                    }
                    return Disposables.create()
                }
            }
            .subscribe(onNext: follow.onNext)
            .disposed(by: disposeBag)
        
        select
            .withLatestFrom(follow) { (indexPath, models) -> String in
                return models[indexPath.row].html_url
            }
            .subscribe(onNext: infoOpen.onNext)
            .disposed(by: disposeBag)
        
        followers = follow.asObserver()
        userInfoOpen = infoOpen.asObserver()
    }
}
