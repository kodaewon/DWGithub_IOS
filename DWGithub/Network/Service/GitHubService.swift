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
    func userRepositories(username: String) -> Observable<[RepositoriesItem]>
}

final class GitHubService: GitHubServiceType {
    func repositories(q: String, page: Int) -> Observable<Repositories> {
        return Observable<Repositories>.create { observable in
            let provider = MoyaProvider<GitHubSearchRepositoriesAPI>()
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
    
    func userRepositories(username: String) -> Observable<[RepositoriesItem]> {
        return Observable<[RepositoriesItem]>.create { observable in
            let provider = MoyaProvider<GitHubUserRepositoriesAPI>()
            provider.request(.search(username: username)) { (result) in
                switch result {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode([RepositoriesItem].self, from: response.data) else {
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
    
    func authRepositories(token: String) -> Observable<[RepositoriesItem]> {
        return Observable<[RepositoriesItem]>.create { observable in
            let provider = MoyaProvider<GitHubUserRepositoriesAPI>()
            provider.request(.repo(token: token)) { (result) in
                switch result {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode([RepositoriesItem].self, from: response.data) else {
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
    
    func contributions(username: String) -> Observable<Contributions> {
        return Observable<Contributions>.create { observable in
            let provider = MoyaProvider<GitHubContributionAPI>()
            provider.request(.getContributino(username: username)) { (result) in
                switch result {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode(Contributions.self, from: response.data) else {
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
    
    func parsingContributions(username: String) -> Observable<[ParsingContribution]> {
        return Observable<[ParsingContribution]>.create { observable in
            self.parsingContribution(username: username) { (item) in
                if let item = item {
                    observable.onNext(item)
                } else {
                    observable.onError(NSError(domain: "", code: 1, userInfo: nil))
                }
            }
            
            return Disposables.create()
        }
    }
}
