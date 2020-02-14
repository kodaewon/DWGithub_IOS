//
//  GitHubUserRepositoriesAPI.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/11.
//  Copyright © 2020 고대원. All rights reserved.
//

import Moya

enum GitHubUserRepositoriesAPI {
    case repo(token: String)
    case search(username: String)
}

extension GitHubUserRepositoriesAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .repo(_):
            return "/user/repos"
        case .search(let username):
            return "/users/\(username)/repos"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
       switch self {
       case .repo(let token):
           return ["Authorization": "token \(token)"]
       case .search(_):
           return nil
       }
    }
}
