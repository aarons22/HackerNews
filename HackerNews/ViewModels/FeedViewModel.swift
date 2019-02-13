//
//  FeedViewModel.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import RxSwift
import RxCocoa

protocol FeedViewModelProtocol {
    func getTopStories()
}

class FeedViewModel: FeedViewModelProtocol {
    private let itemRepository: ItemRepositoryProtocol

    private let newStoryIds = Variable<[Int]>([])
    private let stories = Variable<[Story]>([])

    private let disposeBag = DisposeBag()

    init(itemRepository: ItemRepositoryProtocol = ItemRepository()) {
        self.itemRepository = itemRepository

        self.addBindings()
    }

    private func addBindings() {
        self.newStoryIds.asObservable()
            .bind { [weak self] (ids) in
                if let id = ids.first {

                }
            }.disposed(by: self.disposeBag)

    }

    func getTopStories() {
        self.itemRepository.getTopStories { [weak self] (ids) in
            self?.newStoryIds.value = ids
        }
    }

    func getItem(_ id: Int) {
        self.itemRepository.getItem(id) { (story) in
            self.stories.value.append(story)
        }
    }
}
