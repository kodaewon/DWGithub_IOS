//
//  Contributions.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/17.
//  Copyright © 2020 고대원. All rights reserved.
//

struct Contributions: Codable {
    var years: [ContributionsYear]
    var items: [ContributionsItem]
    
    init() {
        years = []
        items = []
    }
    
    enum Contributions: String, CodingKey {
        case year = "years"
        case items = "contributions"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Contributions.self)
        
        years = (try? values.decode([ContributionsYear].self, forKey: .year)) ?? []
        items = (try? values.decode([ContributionsItem].self, forKey: .items)) ?? []
    }
    
    // MARK: - func
    func yearOfItems(_ year: String) -> [ContributionsItem] {
        return items.filter {
            return $0.date.hasPrefix(year)
            
        }
    }
}
