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
    func getItem(_ id: Int, completion: @escaping (Item) -> Void)
    func getChildren(_ item: Item)
}

class ItemRepository: ItemRepositoryProtocol {
    // User defined
    private let http: HTTPProtocol

    init(http: HTTPProtocol = HTTP()) {
        self.http = http
    }

    func getTopStories(completion: @escaping ([Int]) -> Void) {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json") else { return }
        let request = URLRequest(url: url)
        self.http.request(request) { (result: Result<[Int]>) in
            switch result {
            case .success(let ids):
                completion(ids)
            case .failure(let error):
                consoleLog.error(error.localizedDescription)
            }
        }
    }

    func getItem(_ id: Int, completion: @escaping (Item) -> Void) {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json") else { return }
        let request = URLRequest(url: url)
        self.http.request(request) { (result: Result<Item>) in
            switch result {
            case .success(let item):
                DataManager.shared.items.value.insert(item)
                completion(item)
            case .failure(let error):
                consoleLog.error(error.localizedDescription)
            }
        }
    }

    func getChildren(_ item: Item) {
        // Current approach doesn't provide any concrete way to know when
        // all comments are loaded, but _most_ stories should have all comments
        // loaded by the time a user opens the comments
        if let kids = item.kids {
            for id in kids {
                self.getItem(id) { (kid) in
                    self.getChildren(kid)
                }
            }
        }
    }
}
