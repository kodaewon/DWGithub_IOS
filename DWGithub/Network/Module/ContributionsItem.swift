//
//  ContributionsItem.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/18.
//  Copyright © 2020 고대원. All rights reserved.
//

struct ContributionsItem: Codable {
    var date: String
    var count: Int
    var color: String
    var intensity: Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        date = (try? values.decode(String.self, forKey: .date)) ?? ""
        count = (try? values.decode(Int.self, forKey: .count)) ?? 0
        color = (try? values.decode(String.self, forKey: .color)) ?? ""
        intensity = (try? values.decode(Int.self, forKey: .intensity)) ?? 0
    }
}
