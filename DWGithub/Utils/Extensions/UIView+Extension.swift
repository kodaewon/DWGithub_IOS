//
//  UIView+Extension.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

extension UIView {
    func addAutoLayoutSubViews(_ subviews: [UIView]) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}
