//
//  CommentView.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/13/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import UIKit

class CommentView: UIView {
    // UI
    let stackView = UIStackView()
    let childrenView = CommentsView()
    let titleLabel = UILabel()
    let textLabel = UILabel()

    // Internal
    private let comment: Item

    init(comment: Item) {
        self.comment = comment
        super.init(frame: .zero)

        self.setupStackView()

        self.titleLabel.text = "\(comment.by) \(comment.createdAt.getElapsedInterval()) ago"
        self.textLabel.text = comment.body

        self.childrenView.display(comment.children, isRoot: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStackView() {
        self.addSubview(self.stackView)
        self.stackView.axis = .vertical
        self.stackView.spacing = 5
        self.stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.setupTitleLabel()
        self.setupTextView()
        self.setupChildrenView()
    }

    private func setupTitleLabel() {
        self.stackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
        self.titleLabel.textColor = Colors.gray400
    }

    private func setupTextView() {
        self.stackView.addArrangedSubview(self.textLabel)
        self.textLabel.numberOfLines = 0
        self.textLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
    }

    private func setupChildrenView() {
        self.stackView.addArrangedSubview(self.childrenView)
    }
}
