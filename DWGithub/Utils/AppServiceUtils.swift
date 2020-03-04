//
//  AppServiceUtils.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/22.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit
import Foundation

class AppServiceUtils {
    // MARK: - version func
    static func versionUpdate(_ isUpdate: Bool) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var msgString = "최신 버전 입니다"
        if isUpdate {
            msgString = "업데이트 버전이 있습니다\n스토어로 이동하시겠습니까?"
        }
        
        let alert = UIAlertController(title: "", message: msgString, preferredStyle: .alert)
        
        if isUpdate {
            let okAction = UIAlertAction(title: "확인", style: .default) { (actino) in
                if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(Constants.appStoreAppleID)"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
        } else {
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(okAction)
        }
        
        DispatchQueue.main.async(execute: {
            delegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
        })
    }
    
    static func versionInfo() -> (String, Bool) {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=com.kodaewon.DWGithub"),
            let data = try? Data(contentsOf: url),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
            let results = json["results"] as? [[String: Any]],
            results.count > 0,
            let appStoreVersion = results[0]["version"] as? String else {
                return ("버전 정보를 가져오지 못했습니다", false)
        }
         
        if version.contains(appStoreVersion) {
            return ("v\(version) (최신버전)", false)
        } else {
            return ("v\(version) (업데이트 버전이 있습니다)", true)
        }
    }
}

extension AppServiceUtils {
    static func goSetting() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url,
                                      options: [:],
                                      completionHandler: nil)
        }
    }
}
