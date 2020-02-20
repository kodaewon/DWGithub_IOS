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
    
    static func confirm(parentVC: UIViewController?, title: String? = nil, message: String? = nil, okAction: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localized(), style: .default) { (action) in
            alert.dismiss(animated: true, completion: {
                okAction?()
            })
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: {
                cancelAction?()
            })
        }
        alert.addAction(cancelAction)
        
        if let vc = parentVC {
            DispatchQueue.main.async(execute: {
                vc.present(alert, animated: true, completion: nil)
            })
        }
    }
}
