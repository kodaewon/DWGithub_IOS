//
//  GitHubLoginViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/07.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit
import WebKit

import RxCocoa
import RxSwift

class GitHubLoginViewController: BaseViewController {
    
    // MARK: - view properties
    private var githubLoginView: GitHubLoginView { return view as! GitHubLoginView }
    
    private var webView: WKWebView { return githubLoginView.webView }
    
    // MARK: - properties
    private let viewModel: GitHubViewModel = GitHubViewModel()
    
    private var githubLoginURL: String { return GitHubAPI.loginAuthURL +
                                        "?client_id="+GitHubConstans.clientID +
                                        "&scope"+GitHubConstans.scope +
                                        "&redirect_uri="+GitHubConstans.calbackURL +
                                        "&state="+"403" }
    
    override func loadView() {
        view = GitHubLoginView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
  
        initNavigationBar()
        
        bind()
    }
    
    // MARK: - actions
     @objc private func closeDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - WKUIDelegate, WKNavigationDelegate
extension GitHubLoginViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("start \(webView.url?.absoluteString)")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}

// MARK: - bind
extension GitHubLoginViewController {
    func bind() {
        // input
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: githubLoginURL)!))
        
        // output
    }
}

// MARK: - init
extension GitHubLoginViewController {
    func initNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationItem.title = "GitHubLogin"
        
        let closeButton = UIBarButtonItem(title: "Close",
                                          style: .done,
                                          target: self,
                                          action: #selector(closeDidTap))
        
        navigationItem.leftBarButtonItem = closeButton
    }
}
