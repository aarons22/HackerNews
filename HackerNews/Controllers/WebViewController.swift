//
//  WebViewController.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    let webView = WKWebView()

    init(url: URL) {
        super.init(nibName: nil, bundle: nil)

        let request = URLRequest(url: url)
        self.webView.load(request)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupWebView()
        self.setupToolBar()

        self.navigationController?.isToolbarHidden = false
    }

    private func setupNavigationBar() {
        // TODO: use custom icons
        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItems = [done]
    }

    private func setupWebView() {
        self.view.addSubview(self.webView)
        self.webView.allowsBackForwardNavigationGestures = true
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    private func setupToolBar() {
        // TODO: use custom icons
        let back = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.rewind,
                                   target: self.webView,
                                   action: #selector(self.webView.goBack))
        let forward = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fastForward,
                                      target: self.webView,
                                      action: #selector(self.webView.goForward))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh,
                                      target: self.webView,
                                      action: #selector(self.webView.reload))

        self.toolbarItems = [back, forward, spacer, refresh]
    }

    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
