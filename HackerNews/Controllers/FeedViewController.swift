//
//  FeedViewController.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/12/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import WebKit

class FeedViewController: UIViewController {
    let viewModel: FeedViewModelProtocol

    let tableView = UITableView()

    private let disposeBag = DisposeBag()

    init(viewModel: FeedViewModelProtocol = FeedViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = "Top Stories"

        viewModel.delegate = self

        self.addBindings()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addBindings() {
        self.viewModel.stories.asObservable()
            .bind { [weak self] (_) in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }.disposed(by: self.disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()

        self.viewModel.getTopStories()
    }

    func setupTableView() {
        self.view.addSubview(tableView)
        self.tableView.delegate = self.viewModel
        self.tableView.dataSource = self.viewModel
        self.tableView.separatorInset = .zero
        self.tableView.register(StoryTableViewCell.self, forCellReuseIdentifier: String(describing: StoryTableViewCell.self))
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaInsets)
        }
    }
}

extension FeedViewController: FeedViewModelDelegate {
    func displayStory(_ story: Story) {
        if let url = story.url {
            let viewController = WebViewController(url: url)
            let navController = NavigationController(rootViewController: viewController)
            self.navigationController?.present(navController, animated: true, completion: nil)
        } else {
            let viewModel = StoryViewModel(story)
            let viewController = StoryViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
