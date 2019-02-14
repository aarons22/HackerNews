//
//  WebViewController.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import UIKit
import WebKit
import AwesomeEnum
import MBProgressHUD

class WebViewController: UIViewController, WKNavigationDelegate {
    // UI
    private let webView = WKWebView()
    private var backButton: BarButton!
    private var forwardButton: BarButton!

    // User Defined
    let story: Item

    init(url: URL, story: Item) {
        self.story = story
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

        self.navigationController?.navigationBar.tintColor = Colors.gray400
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.tintColor = Colors.HackerNews.orange
    }

    private func setupNavigationBar() {
        let done = BarButton(icon: Awesome.Solid.chevronDown,
                             target: self,
                             action: #selector(close))
        self.navigationItem.leftBarButtonItems = [done]
    }

    private func setupWebView() {
        self.view.addSubview(self.webView)
        self.webView.allowsBackForwardNavigationGestures = true
        self.webView.navigationDelegate = self
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    private func setupToolBar() {
        self.backButton = BarButton(icon: Awesome.Solid.chevronLeft,
                                    target: self.webView,
                                    action: #selector(self.webView.goBack))
        self.backButton.isEnabled = false
        self.forwardButton = BarButton(icon: Awesome.Solid.chevronRight,
                                       target: self.webView,
                                       action: #selector(self.webView.goForward))
        self.forwardButton.isEnabled = false
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let comments = BarButton(icon: Awesome.Regular.commentAlt,
                                 target: self,
                                 action: #selector(self.showComments))
        comments.isEnabled = self.story.hasKids
        let refresh = BarButton(icon: Awesome.Solid.redo,
                                target: self.webView,
                                action: #selector(self.webView.reload))

        self.toolbarItems = [self.backButton, self.forwardButton, spacer, comments, spacer, refresh]
    }

    @objc private func close() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func back() {
        if self.webView.canGoBack {
            self.webView.go
        }
    }

    @objc private func showComments() {
        let viewModel = CommentsViewModel(story: self.story)
        let viewController = CommentsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        MBProgressHUD.showAdded(to: self.view, animated: false)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        MBProgressHUD.hide(for: self.view, animated: false)
        self.backButton.isEnabled = webView.canGoBack
        self.forwardButton.isEnabled = webView.canGoForward
    }
}

class BarButton: UIBarButtonItem {
    init<AmazingType: Amazing>(icon: AmazingType, target: Any?, action: Selector?) {
        super.init()
        let image = icon.asImage(size: 30).withRenderingMode(.alwaysTemplate)
        self.image = image
        self.target = target as AnyObject
        self.action = action
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
