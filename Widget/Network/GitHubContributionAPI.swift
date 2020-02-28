//
//  GitHubContributionAPI.swift
//  Widget
//
//  Created by 고대원 on 2020/02/22.
//  Copyright © 2020 고대원. All rights reserved.
//

import Moya

enum GitHubContributionAPI {
    case getContributino(username: String)
    case parsingContribution(username: String)
}

extension GitHubContributionAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .getContributino(_):
            return URL(string: "https://github-contributions-api.now.sh")!
        case .parsingContribution(_):
            return URL(string: "https://github.com")!
        }
    }

    var path: String {
        switch self {
        case .getContributino(let username):
            return "/v1/\(username)"
        case .parsingContribution(let username):
            return "/users/\(username)/contributions"
        }
    }
    
    var method: Method {
        switch self {
        case .getContributino(_):
            return .get
        case .parsingContribution(_):
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

extension GitHubService {
    func parsingContribution(username: String, completion: @escaping (([ParsingContribution]?) -> Void)) {
        let provider = MoyaProvider<GitHubContributionAPI>()
        provider.request(.parsingContribution(username: username)) { (result) in
            switch result {
            case .success(let response):
                guard response.statusCode == 200, var json = String(data: response.data, encoding: .utf8)  else {
                    completion(nil)
                    return
                }
                
                var results: [String] = []
                while json.contains("<rect class=") {
                    if let range = json.range(of: "<rect class=") {
                        json.removeSubrange(json.startIndex..<range.lowerBound)
                        if let endRange = json.range(of: "/>") {
                            results.append(String(json[json.startIndex..<endRange.upperBound]))
                            json.removeSubrange(json.startIndex..<endRange.lowerBound)
                        }
                    }
                }
                
                var contributionItem: [ParsingContribution] = []
                for result in results {
                    var item: ParsingContribution = ParsingContribution()
                    item.date = self.setParsingContribution(key: "data-date", parsingString: result)
                    item.count = self.setParsingContribution(key: "data-count", parsingString: result)
                    item.color = self.setParsingContribution(key: "fill", parsingString: result)
                    
                    contributionItem.append(item)
                }
                
                completion(contributionItem)
                
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func setParsingContribution(key: String, parsingString: String) -> String {
        var parsing = parsingString
        guard parsing.contains("\(key)=\""), let range = parsing.range(of: "\(key)=\"") else { return "" }
        parsing.removeSubrange(parsing.startIndex..<range.upperBound)
        if let endRange = parsing.range(of: "\"") {
            return String(parsing[parsing.startIndex..<endRange.lowerBound])
        }
        
        return ""
    }
}
