//
//  UIAlertController+Extension.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/30.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit

extension UIAlertController {
    func addActions(actions: [UIAlertAction]) {
        actions.forEach {
            addAction($0)
        }
    }
    
    static func basicAlert(parentVC: UIViewController?, title: String? = nil, message: String? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        
        if let vc = parentVC {
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
