//
//  GitHubLoginView.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/07.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit
import WebKit

import SnapKit
import Then

class GitHubLoginView: UIView {
    
    // MARK: - view properties
    let webView = WKWebView().then {
        $0.scrollView.bounces = false
        $0.scrollView.bouncesZoom = false
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - setup
extension GitHubLoginView {
    func setupViews() {
        backgroundColor = .white
        
        addAutoLayoutSubViews([webView])
        
        webView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
}
