//
//  CommentsViewModel.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/13/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import Foundation

protocol CommentsViewModelProtocol {
    var story: Item { get }
}

class CommentsViewModel: NSObject, CommentsViewModelProtocol {
    let story: Item

    init(story: Item) {
        guard story.type == .story else {
            fatalError("Provided item of type \(story.type), but CommentsViewModel requires .story")
        }
        self.story = story
        super.init()
    }
}
