//
//  PostsViewController.swift
//  Assignment_Pushker
//
//  Created by Pushker Pandey on 12/03/25.
//

import UIKit
import RxSwift
import RxCocoa

class PostsViewController: UIViewController {
    @IBOutlet weak var postTableView: UITableView!

    let viewModel = PostsViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewIfNeeded()
        setupTableView()
        bindViewModel()
        viewModel.fetchPosts()
    }

    private func setupTableView() {
        // ✅ Ensure tableView is registered with the correct identifier
//        self.postTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
    }

    private func bindViewModel() {
        viewModel.posts
            .bind(to: postTableView.rx.items(cellIdentifier: PostTableViewCell.identifier, cellType: PostTableViewCell.self)) { _, post, cell in
                let isFavorite = RealmManager.shared.isPostFavorite(post)
                cell.configure(with: post, isFavorite: isFavorite)
            }
            .disposed(by: disposeBag)

        // ✅ Handle row selection
        postTableView.rx.modelSelected(Post.self)
            .subscribe(onNext: { post in
                RealmManager.shared.toggleFavorite(post: post)
            })
            .disposed(by: disposeBag)
    }
}
