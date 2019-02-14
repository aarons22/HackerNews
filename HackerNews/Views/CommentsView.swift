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

    init() {
        super.init(frame: .zero)

        self.setupStackView()
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

        self.stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.stackView.isLayoutMarginsRelativeArrangement = true
    }

    func display(_ comments: [Item]) {
        self.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for comment in comments {
            let commentView = CommentView(comment: comment)
            self.stackView.addArrangedSubview(commentView)
        }
    }
}
