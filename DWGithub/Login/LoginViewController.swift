//
//  LoginViewController.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/06.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit
import WebKit

import RxCocoa
import RxSwift

class LoginViewController: BaseViewController {
    
    // MARK: - view properties
    private var loginView: LoginView { view as! LoginView }
    
    private var gitHubLoginButton: UIButton { loginView.gitHubLoginButton }
    
    // MARK: - lifecycle
    override func loadView() {
        view = LoginView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }
    
    // MARK: - actions
    private func loginDidTap() {
        let nc = BaseNavigationController()
        let vc = GitHubLoginViewController()
        vc.delegate = self
        nc.setViewControllers([vc], animated: true)
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true, completion: nil)
    }
}

// MARK: - GitHubLoginViewControllerDelegate
extension LoginViewController: GitHubLoginViewControllerDelegate {
    func userSuccess() {
        let vc = MainTabBarController()
        navigationController?.setViewControllers([vc], animated: true)
    }
}

// MARK: - bind
extension LoginViewController {
    func bind() {
        gitHubLoginButton.rx.tap
            .subscribe(onNext: { [weak self] in self?.loginDidTap() })
            .disposed(by: disposeBag)
    }
}
