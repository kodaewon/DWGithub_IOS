//
//  GitHubSearchRepositoriesAPI.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/05.
//  Copyright © 2020 고대원. All rights reserved.
//

import Moya

enum GitHubSearchRepositoriesAPI {
    case search(q: String, page: Int)
}

extension GitHubSearchRepositoriesAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .search(_, _):
            return "/search/repositories"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let q, let page):
            return .requestParameters(parameters: [
                "q": q,
                "page": page], encoding: URLEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json; charset=utf-8"]
    }
}
