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
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
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
    
    static var groupBackground: UIColor = {
        if #available(iOS 13.0, *) {
            return .systemGroupedBackground
        }
        return .groupTableViewBackground
    }()
    
    static var background: UIColor = {
        if #available(iOS 13.0, *) {
            return .systemBackground
        }
        return .white
    }()
    
    static var groupText: UIColor = {
        if #available(iOS 13.0, *) {
            return .secondaryLabel
        }
        return .lightGray
    }()
    
    static var text: UIColor = {
        if #available(iOS 13.0, *) {
            return .label
        }
        return .black
    }()
    
    static var tint: UIColor = {
        if #available(iOS 13.0, *) {
            return .label
        }
        return .black
    }()
}
