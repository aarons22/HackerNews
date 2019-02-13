//
//  Story.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import Foundation

class Story: Codable, Equatable {
    let id: Int
    let by: String
    let descendants: Int
    let score: Int
    let time: Date
    let title: String
    let url: URL?

    var urlHost: String? {
        if let url = self.url,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            return components.host?.replacingOccurrences(of: "www.", with: "")
        }
        return nil
    }

    static func == (lhs: Story, rhs: Story) -> Bool {
        return lhs.id == rhs.id
    }
}
