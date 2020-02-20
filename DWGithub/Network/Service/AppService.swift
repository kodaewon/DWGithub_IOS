//
//  AppService.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/20.
//  Copyright © 2020 고대원. All rights reserved.
//

import Foundation

import RxSwift

protocol AppServiceType {
    func getRequest(urlString: String, completion: @escaping ((Result<Data, Error>) -> Void))
}

final class AppService: AppServiceType {
    func getRequest(urlString: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 403, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}

extension AppService {
    func rx_getRequest(urlString: String) -> Observable<Data> {
        return Observable<Data>.create { observable in
            self.getRequest(urlString: urlString) { (result) in
                switch result {
                case .success(let data):
                    observable.onNext(data)
                case .failure(let error):
                    observable.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
