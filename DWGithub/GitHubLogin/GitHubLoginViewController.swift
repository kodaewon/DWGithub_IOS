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

@objc protocol GitHubLoginViewControllerDelegate {
    @objc optional func userSuccess()
}

class GitHubLoginViewController: BaseViewController {
    
    // MARK: - view properties
    private var githubLoginView: GitHubLoginView { return view as! GitHubLoginView }
    
    private var webView: WKWebView { return githubLoginView.webView }
    
    // MARK: - properties
    weak var delegate: GitHubLoginViewControllerDelegate?
    
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

// MARK: - bind
extension GitHubLoginViewController {
    func bind() {
        // input
        webView.load(URLRequest(url: URL(string: githubLoginURL)!))
        
        // output
        webView.rx.decidePolicy
            .subscribe(onNext: { (webview, action, hander) in
                guard let url = webview.url?.absoluteString,
                let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    self.dismiss(animated: true) {
                        UIAlertController.basicAlert(parentVC: self, title: "", message: "다시 시도해 주세요")
                    }
                    hander(.cancel)
                    return
                }
                
                print("urlString = \(String(describing: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))")
                
                if urlString.contains("https://github.com/kodaewon?code=") {
                    let urlStrings = urlString.replacingOccurrences(of: "https://github.com/kodaewon?code=", with: "").components(separatedBy: "&")
                    
                    guard let code = urlStrings.first, code.count > 0 else {
                        self.dismiss(animated: true) {
                            UIAlertController.basicAlert(parentVC: self, title: "", message: "다시 시도해 주세요")
                        }
                        hander(.cancel)
                        return
                    }
                    
                    GitHubAPI.getToken(code: code) { (token) in
                        guard let token = token else {
                            self.dismiss(animated: true) {
                                UIAlertController.basicAlert(parentVC: self, title: "", message: "다시 시도해 주세요")
                            }
                            return
                        }
                        
                        GitHubAPI.userInfo(token: token) { (userInfo) in
                            guard let userInfo = userInfo else {
                                self.dismiss(animated: true) {
                                    UIAlertController.basicAlert(parentVC: self, title: "", message: "다시 시도해 주세요")
                                }
                                return
                            }
                            
                            if let groupUserDefault = UserDefaults(suiteName: "group.DWGitHub") {
                                groupUserDefault.set(userInfo.login, forKey: "login")
                                groupUserDefault.synchronize()
                            }
                            
                            UserDefaults.standard.set(token, forKey: USER_TOKEN)
                            UserDefaults.standard.synchronize()
                            
                            UserInfo.shared = userInfo
                            UserInfo.shared.token = token
                            
                            self.dismiss(animated: true) { [weak self] in
                                self?.delegate?.userSuccess?()
                            }
                        }
                    }
                    
                    hander(.cancel)
                    return
                }
                
                hander(.allow)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - init
extension GitHubLoginViewController {
    func initNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationItem.title = "GitHub Login".localized()
        
        let closeButton = UIBarButtonItem(title: "Close".localized(),
                                          style: .done,
                                          target: self,
                                          action: #selector(closeDidTap))
        
        navigationItem.leftBarButtonItem = closeButton
    }
}
