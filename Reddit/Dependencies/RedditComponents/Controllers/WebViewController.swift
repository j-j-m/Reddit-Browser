//
//  WebViewController.swift
//  Reddit
//
//  Created by Jacob Martin on 5/12/18.
//  Copyright © 2018 jjm. All rights reserved.
//

import UIKit
import WebKit
import RedditComponents

public class WebViewController: UIViewController {
    
    public var urlString: String = "" {
        didSet {
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                loadIndicator.startAnimating()
                webView.load(request)
            }
        }
    }
    
    lazy var loadIndicator: UIActivityIndicatorView = {
        let a = UIActivityIndicatorView()
        a.autolayoutMode()
        a.color = .black
        return a
    }()
    
    lazy var webView: WKWebView = {
        let w = WKWebView()
        w.autolayoutMode()
        w.alpha = 0.0
        w |> background(color: .white)
        w.navigationDelegate = self
        return w
    }()
    
    override public func loadView() {
        
        let view = GradientView()
        view.backgroundColor = .cyan
        
        view.addSubview(loadIndicator)
        view.addSubview(webView)
        
        self.view = view
        view.setGradient(with: .topBottom, start: .white, end: .lightGray)
        
        prepareConstraints()
        
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never

    }
    
    func prepareConstraints() {
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
}

extension WebViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadIndicator.stopAnimating()
        UIView.animate(withDuration: 0.75) {
            self.webView.alpha = 1.0
        }
    }
}
