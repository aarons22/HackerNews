//
//  Story.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import Foundation

enum ItemType: String, Codable {
    case story
    case comment
}

class Item: Codable, Equatable {
    let id: Int
    let kids: [Int]?
    let text: String?
    let url: URL?
    let parent: Int?
    let title: String?
    let score: Int?

    var children: [Item]? = [Item]()

    // For the purposes of this project, we're only using stories and comments
    // which have all of these properties
    let type: ItemType
    let by: String
    let time: Date

    var points: String {
        var descriptor = "points"
        if self.score == 1 {
            descriptor = "point"
        }
        return "\(self.score ?? 0) \(descriptor)"
    }

    var subtitle: String {
        return "\(self.points) by \(by)"
    }

    var body: String? {
        guard let data = self.text?.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        return attributedString.string
    }

    // MARK: - Story

    var urlHost: String? {
        if let url = self.url,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            return components.host?.replacingOccurrences(of: "www.", with: "")
        }
        return nil
    }

    // MARK: - Equatable
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}
