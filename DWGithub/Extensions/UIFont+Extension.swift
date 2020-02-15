//
//  UIFont+Extension.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

// MARK: - App Font
extension UIFont {
    open class func regular(_ size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size)
//        return UIFont(name: "AppleSDGothicNeo-Regular", size: size)!
    }
    
    open class func light(_ size: CGFloat) -> UIFont {
        return .italicSystemFont(ofSize: size)
//        return UIFont(name: "AppleSDGothicNeo-Light", size: size)!
    }
    
    open class func bold(_ size: CGFloat) -> UIFont {
        return .boldSystemFont(ofSize: size)
//        return UIFont(name: "AppleSDGothicNeo-Bold", size: size)!
    }
}
