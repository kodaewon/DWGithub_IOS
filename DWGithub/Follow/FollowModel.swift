//
//  FollowModel.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/20.
//  Copyright © 2020 고대원. All rights reserved.
//

struct FollowModel: Codable {
    var login: String
    var id: Int
    var avatar_url: String
    var url: String
    var html_url: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        login = (try? values.decode(String.self, forKey: .login)) ?? ""
        id = (try? values.decode(Int.self, forKey: .id)) ?? 0
        avatar_url = (try? values.decode(String.self, forKey: .avatar_url)) ?? ""
        url = (try? values.decode(String.self, forKey: .url)) ?? ""
        html_url = (try? values.decode(String.self, forKey: .html_url)) ?? ""
    }
}

//{
//    "login": "ondo-twowix",
//    "id": 36027124,
//    "node_id": "MDQ6VXNlcjM2MDI3MTI0",
//    "avatar_url": "https://avatars3.githubusercontent.com/u/36027124?v=4",
//    "gravatar_id": "",
//    "url": "https://api.github.com/users/ondo-twowix",
//    "html_url": "https://github.com/ondo-twowix",
//    "followers_url": "https://api.github.com/users/ondo-twowix/followers",
//    "following_url": "https://api.github.com/users/ondo-twowix/following{/other_user}",
//    "gists_url": "https://api.github.com/users/ondo-twowix/gists{/gist_id}",
//    "starred_url": "https://api.github.com/users/ondo-twowix/starred{/owner}{/repo}",
//    "subscriptions_url": "https://api.github.com/users/ondo-twowix/subscriptions",
//    "organizations_url": "https://api.github.com/users/ondo-twowix/orgs",
//    "repos_url": "https://api.github.com/users/ondo-twowix/repos",
//    "events_url": "https://api.github.com/users/ondo-twowix/events{/privacy}",
//    "received_events_url": "https://api.github.com/users/ondo-twowix/received_events",
//    "type": "User",
//    "site_admin": false
//},
