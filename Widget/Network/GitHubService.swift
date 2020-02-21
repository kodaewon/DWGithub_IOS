//
//  GitHubService.swift
//  Widget
//
//  Created by 고대원 on 2020/02/22.
//  Copyright © 2020 고대원. All rights reserved.
//

import Alamofire
 
class GitHubService {
    let url = "https://github.com/"
    
    init() {
        
    }
    
    func parsingContribution(username: String, completion: @escaping (([ParsingContribution]?) -> Void)) {
        let path = "users/\(username)/contributions"
        
//        Alamofire.request
    }
}
