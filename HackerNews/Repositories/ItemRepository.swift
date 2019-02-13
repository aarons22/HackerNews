//
//  ItemRepository.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import Foundation
import Alamofire

protocol ItemRepositoryProtocol {
    func getTopStories(completion: @escaping ([Int]) -> Void)
    func getItem(_ id: Int, completion: @escaping (Story) -> Void)
}

class ItemRepository: ItemRepositoryProtocol {
    private let http: HTTPProtocol
    private let decoder = JSONDecoder()

    init(http: HTTPProtocol = HTTP()) {
        self.http = http
    }

    func getTopStories(completion: @escaping ([Int]) -> Void) {
        self.http.request("https://hacker-news.firebaseio.com/v0/topstories.json") { [weak self] (result: Result<[Int]>) in
            switch result {
            case .success(let ids):
                completion(ids)
            case .failure(let error):
                // TODO
                break
            }
        }
    }

    func getItem(_ id: Int, completion: @escaping (Story) -> Void) {
        self.http.request("https://hacker-news.firebaseio.com/v0/item/\(id).json") { [weak self] (result: Result<Story>) in
            switch result {
            case .success(let story):
                completion(story)
            case .failure(let error):
                // TODO
                break
            }
        }
    }
}
