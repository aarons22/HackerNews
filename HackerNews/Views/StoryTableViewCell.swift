//
//  StoryTableViewCell.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    func display(_ story: Story) {
        self.textLabel?.text = story.title
    }
}
