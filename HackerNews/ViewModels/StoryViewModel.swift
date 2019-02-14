//
//  StoryViewModel.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import Foundation

protocol StoryViewModelProtocol: class {
    var story: Item { get }
}

class StoryViewModel: NSObject, StoryViewModelProtocol {
    // User Defined
    let story: Item

    init(_ story: Item) {
        self.story = story
        super.init()
    }
}
