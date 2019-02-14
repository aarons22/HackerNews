//
//  CommentsViewController.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/13/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    // User Defined
    let viewModel: CommentsViewModelProtocol

    // UI
    private let scrollView = UIScrollView()
    private let commentsView = CommentsView()

    init(viewModel: CommentsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        self.title = "Comments"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupScrollView()
        self.commentsView.display(viewModel.story.children, isRoot: true)
    }

    private func setupScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.scrollView.backgroundColor = Colors.HackerNews.background
        self.scrollView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

        self.setupCommentsView()
    }

    private func setupCommentsView() {
        self.scrollView.addSubview(self.commentsView)
        self.commentsView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(self.view).inset(10)
        }
    }
}
