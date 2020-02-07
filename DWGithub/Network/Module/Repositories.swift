//
//  Repositories.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/05.
//  Copyright © 2020 고대원. All rights reserved.
//

struct Repositories: Codable {
    var total_count: Int
    var incomplete_results: Bool
    var items: [RepositoriesItem]
    
    init() {
        total_count = 0
        incomplete_results = false
        items = []
    }
    
    init(from decoder: Decoder) throws {
       let values = try decoder.container(keyedBy: CodingKeys.self)
       
       total_count = (try? values.decode(Int.self, forKey: .total_count)) ?? 0
       incomplete_results = (try? values.decode(Bool.self, forKey: .incomplete_results)) ?? false
       items = (try? values.decode([RepositoriesItem].self, forKey: .items)) ?? []
    }
}
