//
//  FavoritesViewController.swift
//  Assignment_Pushker
//
//  Created by Pushker Pandey on 12/03/25.
//

import UIKit
import RxSwift
import RxCocoa
import Realm

class FavoritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = FavoritesViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchFavorites()
        
        viewModel.favorites.bind(to: tableView.rx.items(cellIdentifier: "PostCell", cellType: PostTableViewCell.self)) { _, post, cell in
            cell.configure(with: post, isFavorite: false)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
            let post = self?.viewModel.favorites.value[indexPath.row]
            RealmManager.shared.removeFavorite(post: post!)
            self?.viewModel.fetchFavorites()
        }).disposed(by: disposeBag)
    }
}
