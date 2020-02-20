//
//  UIUserInterfaceStyle+Extension.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/19.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

// MARK: - UIUserInterfaceStyle
@available(iOS 12.0, *)
extension UIUserInterfaceStyle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .light:
            return "라이트 모드"
        case .dark:
            return "다크 모드"
        case .unspecified:
            return "시스템 모드"
        }
    }
}
