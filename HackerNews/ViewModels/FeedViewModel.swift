//
//  FeedViewModel.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import RxSwift
import RxCocoa

protocol FeedViewModelProtocol: UITableViewDelegate, UITableViewDataSource {
    var stories: Variable<[Story]> { get }

    func getTopStories()
}

class FeedViewModel: NSObject, FeedViewModelProtocol {
    private let itemRepository: ItemRepositoryProtocol

    private let newStoryIds = Variable<[Int]>([])
    let stories = Variable<[Story]>([])

    private let disposeBag = DisposeBag()

    init(itemRepository: ItemRepositoryProtocol = ItemRepository()) {
        self.itemRepository = itemRepository
        super.init()
        self.addBindings()
    }

    private func addBindings() {
        self.newStoryIds.asObservable()
            .bind { [weak self] (ids) in
                self?.getFirstStories()
            }.disposed(by: self.disposeBag)
    }

    func getTopStories() {
        self.itemRepository.getTopStories { [weak self] (ids) in
            self?.newStoryIds.value = ids
        }
    }

    private func getFirstStories() {
        let limit = (min(self.newStoryIds.value.count, 20))
        guard limit != 0 else { return }

        for i in 0...limit {
            let id = self.newStoryIds.value[i]
            self.getItem(id)
        }
    }

    func getItem(_ id: Int) {
        self.itemRepository.getItem(id) { (story) in
            self.stories.value.append(story)
        }
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stories.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StoryTableViewCell.self),
                                                       for: indexPath) as? StoryTableViewCell else {
                                                        return UITableViewCell()
        }

        let story = self.stories.value[indexPath.row]
        cell.display(story)
        return cell
    }
}
