//
//  JadiCollectionDataSource.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/20.
//  Copyright © 2020 고대원. All rights reserved.
//

import RxDataSources

struct JandiItem {
    var title = ""
    var item: ParsingContribution?
    var items: [ParsingContribution]
}

struct SectionOfJadiItem {
    var header: String
    var items: [JandiItem]
}

extension SectionOfJadiItem: SectionModelType {
    init(original: SectionOfJadiItem, items: [JandiItem]) {
        self = original
        self.items = items        
    }
}
