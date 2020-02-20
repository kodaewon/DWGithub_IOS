//
//  GitHubContributionAPI.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/17.
//  Copyright © 2020 고대원. All rights reserved.
//

import Moya

enum GitHubContributionAPI {
    case getContributino(username: String)
}

extension GitHubContributionAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .getContributino(_):
            return URL(string: "https://github-contributions-api.now.sh")!
        }
    }
    
    var path: String {
        switch self {
        case .getContributino(let username):
            return "/v1/\(username)"
        }
    }
    
    var method: Method {
        switch self {
        case .getContributino(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return nil
    }
}
