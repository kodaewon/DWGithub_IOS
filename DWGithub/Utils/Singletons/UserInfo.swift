//
//  UserInfo.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/14.
//  Copyright © 2020 고대원. All rights reserved.
//

import Foundation

class UserInfo: NSObject, Codable {
    
    // MARK: - singleton
    static var shared = UserInfo()
    
    // MARK: - properties
    var token: String
    
    var login: String
    var id: Int
    var node_id: String
    var avatar_url: String
    var html_url: String
    var name: String
    var company: String
    var blog: String
    var location: String
    var email: String
    var bio: String
    var followers: Int
    var following: Int
    var followers_url: String
    var following_url: String
    
    var requestFollowingURL: String {
        return following_url.replacingOccurrences(of: "{/other_user}", with: "")
    }
    
    override init() {
        token = ""
        login = ""
        id = 0
        node_id = ""
        avatar_url = ""
        html_url = ""
        name = ""
        company = ""
        blog = ""
        location = ""
        email = ""
        bio = ""
        followers = 0
        following = 0
        followers_url = ""
        following_url = ""
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        token = ""
        
        login = (try? values.decode(String.self, forKey: .login)) ?? ""
        id = (try? values.decode(Int.self, forKey: .id)) ?? 0
        node_id = (try? values.decode(String.self, forKey: .node_id)) ?? ""
        avatar_url = (try? values.decode(String.self, forKey: .avatar_url)) ?? ""
        html_url = (try? values.decode(String.self, forKey: .html_url)) ?? ""
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        company = (try? values.decode(String.self, forKey: .company)) ?? ""
        blog = (try? values.decode(String.self, forKey: .blog)) ?? ""
        location = (try? values.decode(String.self, forKey: .location)) ?? ""
        email = (try? values.decode(String.self, forKey: .email)) ?? ""
        bio = (try? values.decode(String.self, forKey: .bio)) ?? ""
        followers = (try? values.decode(Int.self, forKey: .followers)) ?? 0
        following = (try? values.decode(Int.self, forKey: .following)) ?? 0
        followers_url = (try? values.decode(String.self, forKey: .followers_url)) ?? ""
        following_url = (try? values.decode(String.self, forKey: .following_url)) ?? ""
    }
}


//{
//    "login": "kodaewon",
//    "id": 26591449,
//    "node_id": "MDQ6VXNlcjI2NTkxNDQ5",
//    "avatar_url": "https://avatars1.githubusercontent.com/u/26591449?v=4",
//    "gravatar_id": "",
//    "url": "https://api.github.com/users/kodaewon",
//    "html_url": "https://github.com/kodaewon",
//    "followers_url": "https://api.github.com/users/kodaewon/followers",
//    "following_url": "https://api.github.com/users/kodaewon/following{/other_user}",
//    "gists_url": "https://api.github.com/users/kodaewon/gists{/gist_id}",
//    "starred_url": "https://api.github.com/users/kodaewon/starred{/owner}{/repo}",
//    "subscriptions_url": "https://api.github.com/users/kodaewon/subscriptions",
//    "organizations_url": "https://api.github.com/users/kodaewon/orgs",
//    "repos_url": "https://api.github.com/users/kodaewon/repos",
//    "events_url": "https://api.github.com/users/kodaewon/events{/privacy}",
//    "received_events_url": "https://api.github.com/users/kodaewon/received_events",
//    "type": "User",
//    "site_admin": false,
//    "name": "DW",
//    "company": null,
//    "blog": "https://kodaewon.github.io/",
//    "location": "Seoul, South Korea",
//    "email": "yreak33@gmail.com",
//    "hireable": null,
//    "bio": "IOS Developer",
//    "public_repos": 7,
//    "public_gists": 0,
//    "followers": 2,
//    "following": 9,
//    "created_at": "2017-03-22T06:24:15Z",
//    "updated_at": "2020-02-14T03:58:02Z"
//}
