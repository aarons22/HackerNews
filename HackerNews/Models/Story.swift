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
    let text: String?
    let url: URL?

    var points: String {
        var descriptor = "points"
        if self.score == 1 {
            descriptor = "point"
        }
        return "\(self.score) \(descriptor)"
    }

    var urlHost: String? {
        if let url = self.url,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            return components.host?.replacingOccurrences(of: "www.", with: "")
        }
        return nil
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

    var subtitle: String {
        return "\(self.points) by \(by)"
    }

    static func == (lhs: Story, rhs: Story) -> Bool {
        return lhs.id == rhs.id
    }
}
