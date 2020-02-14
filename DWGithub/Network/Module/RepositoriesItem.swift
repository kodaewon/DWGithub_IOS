//
//  RepositoriesItem.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/05.
//  Copyright © 2020 고대원. All rights reserved.
//

struct RepositoriesItem: Codable {
    var id: Int
    var name: String
    var full_name: String
    var isPrivate: Bool
    var description: String
    var language: String
    var stargazers_count: Int
    var fork: Bool
    var forks: Int
    var forks_url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case full_name = "full_name"
        case isPrivate = "private"
        case description = "description"
        case language = "language"
        case stargazers_count = "stargazers_count"
        case fork = "fork"
        case forks = "forks"
        case forks_url = "forks_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        id = (try? values.decode(Int.self, forKey: .id)) ?? 0
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        full_name = (try? values.decode(String.self, forKey: .full_name)) ?? ""
        isPrivate = (try? values.decode(Bool.self, forKey: .isPrivate)) ?? false
        description = (try? values.decode(String.self, forKey: .description)) ?? ""
        language = (try? values.decode(String.self, forKey: .language)) ?? ""
        stargazers_count = (try? values.decode(Int.self, forKey: .stargazers_count)) ?? 0
        fork = (try? values.decode(Bool.self, forKey: .fork)) ?? false
        forks = (try? values.decode(Int.self, forKey: .forks)) ?? 0
        forks_url = (try? values.decode(String.self, forKey: .forks_url)) ?? ""
    }
}

//    "id": 46806184,
//    "node_id": "MDEwOlJlcG9zaXRvcnk0NjgwNjE4NA==",
//    "name": "charts",
//    "full_name": "helm/charts",
//    "private": false,
//    "owner": {
//        "login": "helm",
//        "id": 15859888,
//        "node_id": "MDEyOk9yZ2FuaXphdGlvbjE1ODU5ODg4",
//        "avatar_url": "https://avatars2.githubusercontent.com/u/15859888?v=4",
//        "gravatar_id": "",
//        "url": "https://api.github.com/users/helm",
//        "html_url": "https://github.com/helm",
//        "followers_url": "https://api.github.com/users/helm/followers",
//        "following_url": "https://api.github.com/users/helm/following{/other_user}",
//        "gists_url": "https://api.github.com/users/helm/gists{/gist_id}",
//        "starred_url": "https://api.github.com/users/helm/starred{/owner}{/repo}",
//        "subscriptions_url": "https://api.github.com/users/helm/subscriptions",
//        "organizations_url": "https://api.github.com/users/helm/orgs",
//        "repos_url": "https://api.github.com/users/helm/repos",
//        "events_url": "https://api.github.com/users/helm/events{/privacy}",
//        "received_events_url": "https://api.github.com/users/helm/received_events",
//        "type": "Organization",
//        "site_admin": false
//    },
//    "html_url": "https://github.com/helm/charts",
//    "description": "Curated applications for Kubernetes",
//    "fork": false,
//    "url": "https://api.github.com/repos/helm/charts",
//    "forks_url": "https://api.github.com/repos/helm/charts/forks",
//    "keys_url": "https://api.github.com/repos/helm/charts/keys{/key_id}",
//    "collaborators_url": "https://api.github.com/repos/helm/charts/collaborators{/collaborator}",
//    "teams_url": "https://api.github.com/repos/helm/charts/teams",
//    "hooks_url": "https://api.github.com/repos/helm/charts/hooks",
//    "issue_events_url": "https://api.github.com/repos/helm/charts/issues/events{/number}",
//    "events_url": "https://api.github.com/repos/helm/charts/events",
//    "assignees_url": "https://api.github.com/repos/helm/charts/assignees{/user}",
//    "branches_url": "https://api.github.com/repos/helm/charts/branches{/branch}",
//    "tags_url": "https://api.github.com/repos/helm/charts/tags",
//    "blobs_url": "https://api.github.com/repos/helm/charts/git/blobs{/sha}",
//    "git_tags_url": "https://api.github.com/repos/helm/charts/git/tags{/sha}",
//    "git_refs_url": "https://api.github.com/repos/helm/charts/git/refs{/sha}",
//    "trees_url": "https://api.github.com/repos/helm/charts/git/trees{/sha}",
//    "statuses_url": "https://api.github.com/repos/helm/charts/statuses/{sha}",
//    "languages_url": "https://api.github.com/repos/helm/charts/languages",
//    "stargazers_url": "https://api.github.com/repos/helm/charts/stargazers",
//    "contributors_url": "https://api.github.com/repos/helm/charts/contributors",
//    "subscribers_url": "https://api.github.com/repos/helm/charts/subscribers",
//    "subscription_url": "https://api.github.com/repos/helm/charts/subscription",
//    "commits_url": "https://api.github.com/repos/helm/charts/commits{/sha}",
//    "git_commits_url": "https://api.github.com/repos/helm/charts/git/commits{/sha}",
//    "comments_url": "https://api.github.com/repos/helm/charts/comments{/number}",
//    "issue_comment_url": "https://api.github.com/repos/helm/charts/issues/comments{/number}",
//    "contents_url": "https://api.github.com/repos/helm/charts/contents/{+path}",
//    "compare_url": "https://api.github.com/repos/helm/charts/compare/{base}...{head}",
//    "merges_url": "https://api.github.com/repos/helm/charts/merges",
//    "archive_url": "https://api.github.com/repos/helm/charts/{archive_format}{/ref}",
//    "downloads_url": "https://api.github.com/repos/helm/charts/downloads",
//    "issues_url": "https://api.github.com/repos/helm/charts/issues{/number}",
//    "pulls_url": "https://api.github.com/repos/helm/charts/pulls{/number}",
//    "milestones_url": "https://api.github.com/repos/helm/charts/milestones{/number}",
//    "notifications_url": "https://api.github.com/repos/helm/charts/notifications{?since,all,participating}",
//    "labels_url": "https://api.github.com/repos/helm/charts/labels{/name}",
//    "releases_url": "https://api.github.com/repos/helm/charts/releases{/id}",
//    "deployments_url": "https://api.github.com/repos/helm/charts/deployments",
//    "created_at": "2015-11-24T17:05:28Z",
//    "updated_at": "2020-02-05T05:40:15Z",
//    "pushed_at": "2020-02-05T05:50:26Z",
//    "git_url": "git://github.com/helm/charts.git",
//    "ssh_url": "git@github.com:helm/charts.git",
//    "clone_url": "https://github.com/helm/charts.git",
//    "svn_url": "https://github.com/helm/charts",
//    "homepage": "",
//    "size": 27708,
//    "stargazers_count": 11904,
//    "watchers_count": 11904,
//    "language": "Go",
//    "has_issues": true,
//    "has_projects": false,
//    "has_downloads": true,
//    "has_wiki": false,
//    "has_pages": false,
//    "forks_count": 12764,
//    "mirror_url": null,
//    "archived": false,
//    "disabled": false,
//    "open_issues_count": 454,
//    "license": {
//        "key": "apache-2.0",
//        "name": "Apache License 2.0",
//        "spdx_id": "Apache-2.0",
//        "url": "https://api.github.com/licenses/apache-2.0",
//        "node_id": "MDc6TGljZW5zZTI="
//    },
//    "forks": 12764,
//    "open_issues": 454,
//    "watchers": 11904,
//    "default_branch": "master",
//    "score": 128.70857
