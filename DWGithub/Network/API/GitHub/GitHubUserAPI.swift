//
//  GitHubUserAPI.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/13.
//  Copyright © 2020 고대원. All rights reserved.
//

import Moya

enum GitHubUserAPI {
    case getToken(code: String)
    case userInfo(token: String)
}

extension GitHubUserAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .getToken(_):
            return URL(string: "https://github.com")!
        case .userInfo(_):
            return URL(string: "https://api.github.com")!
        }
    }
    
    var path: String {
        switch self {
        case .getToken(_):
            return "/login/oauth/access_token"
        case .userInfo(_):
            return "/user"
        }
    }
    
    var method: Method {
        switch self {
        case .getToken(_):
            return .post
        case .userInfo(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getToken(let code):
            return .requestParameters(parameters: [
                "client_id": GitHubConstans.clientID,
                "client_secret": GitHubConstans.clientSercet,
                "code": code,
                "accept": "json"], encoding: URLEncoding.default)
        case .userInfo(_):
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getToken(_):
            return nil
        case .userInfo(let token):
            return ["Authorization": "Bearer \(token)"]
        }
    }
}

extension GitHubAPI {
    static func getToken(code: String, completion: @escaping ((String?) -> Void)) {
        let provider = MoyaProvider<GitHubUserAPI>()
        provider.request(.getToken(code: code)) { (result) in
            switch result {
            case .success(let response):
                if let response = try? response.mapString() {
                    if response.contains("access_token=") {
                        let results = response.components(separatedBy: "&")
                        if let access_token = results.first, access_token.contains("access_token=") {
                            completion(access_token.replacingOccurrences(of: "access_token=", with: ""))
                            return
                        }
                    }
                }
                
                completion(nil)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    static func userInfo(token: String, completion: @escaping ((UserInfo?) -> Void)) {
        let provider = MoyaProvider<GitHubUserAPI>()
        provider.request(.userInfo(token: token)) { (result) in
            switch result {
            case .success(let response):
                guard let userInfo = try? JSONDecoder().decode(UserInfo.self, from: response.data) else {
                    completion(nil)
                    return
                }
                
                completion(userInfo)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
