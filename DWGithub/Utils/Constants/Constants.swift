//
//  Constants.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/19.
//  Copyright © 2020 고대원. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let appStoreAppleID = "1500232711"
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    static let osVersion = UIDevice.current.systemVersion
}
