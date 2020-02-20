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
    
    var followers: Observable<[FollowModel]>
    
    init(domain: AppService = AppService()) {
        let fetch = PublishSubject<String>()
        
        let follow = PublishSubject<[FollowModel]>()
        
        fetchFollow = fetch.asObserver()
        
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
        
        followers = follow.asObserver()
    }
}
