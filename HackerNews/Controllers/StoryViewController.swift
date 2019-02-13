//
//  StoryViewController.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    private let viewModel: StoryViewModelProtocol

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let bodyLabel = UILabel()

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
        self.view.backgroundColor = UIColor.white
        self.setupScrollView()
    }

    private func setupScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10)
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
            make.left.right.equalTo(self.view).inset(10)
        }

        self.setupTitleLabel()
        self.setupSubTitleLabel()
        self.setupBodyLabel()
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
}