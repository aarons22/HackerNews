//
//  StoryViewModel.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import Foundation

protocol StoryViewModelProtocol: class {
    var story: Story { get }
}

class StoryViewModel: NSObject, StoryViewModelProtocol {
    let story: Story

    init(_ story: Story) {
        self.story = story
        super.init()
    }
}
