//
//  WKWebView+rx.swift
//  DWGithub
//
//  Created by 고대원 on 2020/01/17.
//  Copyright © 2020 고대원. All rights reserved.
//

import UIKit
import WebKit

import RxCocoa
import RxSwift

class RxWKNavigationDelegateProxy: DelegateProxy<WKWebView, WKNavigationDelegate>, DelegateProxyType, WKNavigationDelegate {
    
    let decidePolicySubject = PublishSubject<(WKWebView, WKNavigationAction, ((WKNavigationActionPolicy) -> Void))>()
    
    open class func currentDelegate(for object: WKWebView) -> WKNavigationDelegate? {
        return object.navigationDelegate
    }
    
    open class func setCurrentDelegate(_ delegate: WKNavigationDelegate?, to object: WKWebView) {
        object.navigationDelegate = delegate
    }
    
    public init(webView: WKWebView) {
        super.init(parentObject: webView, delegateProxy: RxWKNavigationDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register { RxWKNavigationDelegateProxy(webView: $0) }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decidePolicySubject.onNext((webView, navigationAction, decisionHandler))
    }
}

extension Reactive where Base: WKWebView {
    
    fileprivate var navigationDelegate: RxWKNavigationDelegateProxy {
        return RxWKNavigationDelegateProxy.proxy(for: base)
    }
    
    public var decidePolicy: Observable<(WKWebView, WKNavigationAction, ((WKNavigationActionPolicy) -> Swift.Void))> {
        return navigationDelegate.decidePolicySubject.asObserver()
    }
}
