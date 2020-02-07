//
//  SearchModel.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/07.
//  Copyright © 2020 고대원. All rights reserved.
//

struct SearchModel {
    var q: String
    var page: Int
    var items: [RepositoriesItem]
    
    init() {
        self.q = ""
        self.page = 1
        self.items = []
    }
    
    init(q: String, page: Int, items: [RepositoriesItem]) {
        self.q = q
        self.page = page
        self.items = items
    }
    
    func pageIncrese(inc: Int) -> SearchModel {
        return SearchModel(q: self.q, page: self.page + inc, items: self.items)
    }
}
