//
//  String+Extension.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/19.
//  Copyright © 2020 고대원. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: self) as String
    }
}
