//
//  GitHubService.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import Moya
import RxSwift

protocol GitHubServiceType {
    func repositories(q: String, page: Int) -> Observable<Repositories>
}

final class GitHubService: GitHubServiceType {
    func repositories(q: String, page: Int) -> Observable<Repositories> {
        return Observable<Repositories>.create { observable in
            let provider = MoyaProvider<GitHubRepositoriesAPI>()
            provider.request(.search(q: q, page: page)) { (result) in
                switch result {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode(Repositories.self, from: response.data) else {
                        observable.onError(NSError(domain: "", code: 1, userInfo: nil))
                        return
                    }
                    
                    observable.onNext(data)
                case .failure(_):
                    observable.onError(NSError(domain: "", code: 1, userInfo: nil))
                }
            }
            
            return Disposables.create()
        }
    }
}
