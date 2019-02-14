//
//  FeedViewModel.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import RxSwift
import RxCocoa

protocol FeedViewModelDelegate: class {
    func displayStory(_ story: Item)
}

protocol FeedViewModelProtocol: UITableViewDelegate, UITableViewDataSource {
    var itemRepository: ItemRepositoryProtocol { get }
    var stories: Variable<[Item]> { get }
    var delegate: FeedViewModelDelegate? { get set }

    func getTopStories()
}

class FeedViewModel: NSObject, FeedViewModelProtocol {
    let itemRepository: ItemRepositoryProtocol
    weak var delegate: FeedViewModelDelegate?

    private let storyIds = Variable<[Int]>([])
    let stories = Variable<[Item]>([])

    private let disposeBag = DisposeBag()

    init(itemRepository: ItemRepositoryProtocol = ItemRepository()) {
        self.itemRepository = itemRepository
        super.init()
        self.addBindings()
    }

    private func addBindings() {
        self.storyIds.asObservable()
            .bind { [weak self] (ids) in
                self?.getStories()
            }.disposed(by: self.disposeBag)
    }

    func getTopStories() {
        self.itemRepository.getTopStories { [weak self] (ids) in
            self?.storyIds.value = ids
        }
    }

    private func getStories() {
        // Only grabbing first 50 right. Ideally we'd paginate and
        // load automatically on scroll, but too much effort for the timeframe
        let limit = min(self.storyIds.value.count, 50)
        guard limit != 0 else { return }

        for i in 0...limit {
            let id = self.storyIds.value[i]
            self.getItem(id)
        }
    }

    private func getItem(_ id: Int) {
        self.itemRepository.getItem(id) { [weak self] (story) in
            self?.stories.value.append(story)

            if story.url == nil {
                // Lazy load comments for stories without a external link.
                // Based on current approach to iterating through comments,
                // stories with a link won't display comments until second viewing.
                // Refactor this when we can reliably know when comments are fully loaded in view
                self?.itemRepository.getChildren(story)
            }
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = self.stories.value[indexPath.row]
        self.delegate?.displayStory(story)
    }
}
