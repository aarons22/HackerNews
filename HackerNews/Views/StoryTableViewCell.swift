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
    let pointsLabel = UILabel()
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
        self.titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
    }

    private func setupLowerStackView() {
        self.stackView.addArrangedSubview(self.lowerStackView)
        self.lowerStackView.axis = .horizontal
        self.lowerStackView.spacing = 5
        self.lowerStackView.distribution = .equalCentering

        self.setupPointsLabel()
        self.setupByLabelLabel()
        self.setupURLLabel()
    }

    private func setupPointsLabel() {
        self.lowerStackView.addArrangedSubview(self.pointsLabel)
        self.pointsLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
    }

    private func setupByLabelLabel() {
        self.lowerStackView.addArrangedSubview(self.byLabel)
    }

    private func setupURLLabel() {
        self.lowerStackView.addArrangedSubview(self.urlLabel)
        self.urlLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
    }

    func display(_ story: Story) {
        self.titleLabel.text = story.title
        self.pointsLabel.text = story.points
        self.byLabel.text = "by \(story.by)"
        if let host = story.urlHost {
            self.urlLabel.text = "(via \(host))"
            self.urlLabel.isHidden = false
        } else {
            self.urlLabel.isHidden = true
        }
    }
}
