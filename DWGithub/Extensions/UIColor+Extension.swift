//
//  UIColor+Extension.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

// MARK: - init
extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, a: CGFloat = 1) {
        self.init(red: red/255,
                  green: green/255,
                  blue: blue/255,
                  alpha: a)
    }
}

// MARK: - App Color
extension UIColor {
    static var baisc: UIColor = {
        if #available(iOS 13.0, *) {
            return .green
        }
        return .green
    }()
    
    static var background: UIColor = {
        if #available(iOS 13.0, *) {
            return .systemBackground
        }
        return .white
    }()
    
    static var text: UIColor = {
        if #available(iOS 13.0, *) {
            return .label
        }
        return .black
    }()
}
