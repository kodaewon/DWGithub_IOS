//
//  ContributionsYear.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/17.
//  Copyright © 2020 고대원. All rights reserved.
//

struct ContributionsYearRange: Codable {
    var start: String
    var end: String
    
    init() {
        start = ""
        end = ""
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        start = (try? values.decode(String.self, forKey: .start)) ?? ""
        end = (try? values.decode(String.self, forKey: .end)) ?? ""
    }
}

struct ContributionsYear: Codable {
    var year: String
    var total: Int
    var range: ContributionsYearRange
    
    enum CodingKeys: String, CodingKey {
        case year = "year"
        case total = "total"
        case range = "range"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        year = (try? values.decode(String.self, forKey: .year)) ?? ""
        total = (try? values.decode(Int.self, forKey: .total)) ?? 0
        range = (try? values.decode(ContributionsYearRange.self, forKey: .range)) ?? ContributionsYearRange()
    }
}
