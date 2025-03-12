//
//  FavoritesViewController.swift
//  Assignment_Pushker
//
//  Created by Pushker Pandey on 12/03/25.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class FavoritesViewController: UIViewController {
    @IBOutlet weak var favTableView: UITableView!
    @IBOutlet weak var logOutButton: UIButton!
    
    let viewModel = FavoritesViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutButton.applyStyledAppearance()
        setupTableView()
        bindViewModel()
        viewModel.fetchFavorites()
    }
    
    private func setupTableView() {
        favTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        favTableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let posts = self.viewModel.favorites.value
                
                if indexPath.row < posts.count {
                    let post = posts[indexPath.row]
                    RealmManager.shared.removeFavorite(post: post)
                    self.viewModel.fetchFavorites() // Refresh data
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        viewModel.favorites
            .observe(on: MainScheduler.instance)
            .bind(to: favTableView.rx.items(cellIdentifier: PostTableViewCell.identifier, cellType: PostTableViewCell.self)) { _, post, cell in
                cell.configure(with: post, isFavorite: true)
            }
            .disposed(by: disposeBag)
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn") // Clear login state
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        let navController = UINavigationController(rootViewController: loginVC) // Wrap in NavController
        sceneDelegate.window?.rootViewController = navController
        sceneDelegate.window?.makeKeyAndVisible()
    }
}

