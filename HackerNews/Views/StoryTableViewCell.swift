//
//  StoryTableViewCell.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
    let stackView = UIStackView()
    let lowerStackView = UIStackView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let byLabel = UILabel()
    let urlLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupStackView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStackView() {
        self.addSubview(self.stackView)
        self.stackView.axis = .vertical
        self.stackView.spacing = 5
        self.stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }

        self.setupTitleLabel()
        self.setupLowerStackView()
    }

    private func setupTitleLabel() {
        self.stackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.numberOfLines = 2
        self.titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
    }

    private func setupLowerStackView() {
        self.stackView.addArrangedSubview(self.lowerStackView)
        self.lowerStackView.axis = .horizontal
        self.lowerStackView.spacing = 5
        self.lowerStackView.distribution = .equalCentering

        self.setupSubtitleLabel()
        self.setupURLLabel()
    }

    private func setupSubtitleLabel() {
        self.lowerStackView.addArrangedSubview(self.subtitleLabel)
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
    }

    private func setupURLLabel() {
        self.lowerStackView.addArrangedSubview(self.urlLabel)
        self.urlLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        self.urlLabel.textColor = UIColor.lightGray
    }

    func display(_ story: Item) {
        self.titleLabel.text = story.title
        self.subtitleLabel.text = story.subtitle
        if let host = story.urlHost {
            self.urlLabel.text = "(via \(host))"
            self.urlLabel.isHidden = false
        } else {
            self.urlLabel.isHidden = true
        }
    }
}
