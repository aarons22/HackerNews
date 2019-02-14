//
//  CommentsView.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/13/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import UIKit

class CommentsView: UIView {
    // UI
    private let stackView = UIStackView()
    private let conversationBreakView = UIView()

    init() {
        super.init(frame: .zero)

        self.setupStackView()
        self.setupIndentView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStackView() {
        self.addSubview(self.stackView)
        self.stackView.axis = .vertical
        self.stackView.spacing = 15
        self.stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.stackView.isLayoutMarginsRelativeArrangement = true
    }

    private func setupIndentView() {
        self.stackView.addSubview(self.conversationBreakView)
        self.conversationBreakView.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(1)
        }
        self.conversationBreakView.backgroundColor = Colors.gray200
    }

    func display(_ comments: [Item], isRoot: Bool) {
        self.conversationBreakView.isHidden = isRoot

        let indent: CGFloat = isRoot ? 0 : 15
        self.stackView.layoutMargins = UIEdgeInsets(top: 0, left: indent, bottom: 0, right: 0)

        self.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for comment in comments {
            let commentView = CommentView(comment: comment)
            self.stackView.addArrangedSubview(commentView)
        }
    }
}
