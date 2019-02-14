//
//  StoryViewController.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    // User Defined
    private let viewModel: StoryViewModelProtocol

    // UI
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let commentsTitleLabel = UILabel()
    private let commentsView = CommentsView()

    init(viewModel: StoryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = Colors.HackerNews.background
        self.setupScrollView()
    }

    private func setupScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        self.scrollView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }

        self.setupStackView()
    }

    private func setupStackView() {
        self.scrollView.addSubview(self.stackView)
        self.stackView.axis = .vertical
        self.stackView.spacing = 10
        self.stackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(self.view).inset(15)
        }

        self.setupTitleLabel()
        self.setupSubTitleLabel()
        self.setupBodyLabel()
        self.setupCommentsTitleLabel()
        if self.viewModel.story.hasKids {
            self.setupCommentsView()
        }
    }

    private func setupTitleLabel() {
        self.stackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.text = self.viewModel.story.title
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
    }

    private func setupSubTitleLabel() {
        self.stackView.addArrangedSubview(self.subTitleLabel)
        self.subTitleLabel.text = self.viewModel.story.subtitle
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
    }

    private func setupBodyLabel() {
        self.stackView.addArrangedSubview(self.bodyLabel)
        self.bodyLabel.numberOfLines = 0
        self.bodyLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        if let body = self.viewModel.story.body {
            self.bodyLabel.text = body
        }
    }

    private func setupCommentsTitleLabel() {
        self.stackView.addArrangedSubview(self.commentsTitleLabel)
        self.commentsTitleLabel.text = self.viewModel.story.hasKids ? "Comments" : "No Comments"
        self.commentsTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.heavy)
        self.commentsTitleLabel.textColor = Colors.gray400
    }

    private func setupCommentsView() {
        let container = UIView()
        container.backgroundColor = Colors.gray100
        container.addSubview(self.commentsView)
        self.commentsView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(5)
        }
        self.stackView.addArrangedSubview(container)
        self.commentsView.display(self.viewModel.story.children, isRoot: true)
    }
}
