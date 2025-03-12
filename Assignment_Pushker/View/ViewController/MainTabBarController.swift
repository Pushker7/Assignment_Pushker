//
//  MainTabBarController.swift
//  Assignment_Pushker
//
//  Created by Pushker Pandey on 12/03/25.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let  postsVC = self.storyboard?.instantiateViewController(withIdentifier: "PostsViewController") as! PostsViewController
//        let postsVC = PostsViewController()
        postsVC.tabBarItem = UITabBarItem(title: "Posts", image: UIImage(systemName: "list.bullet"), tag: 0)
        let  favoritesVC = self.storyboard?.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
//        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)

        let navPosts = UINavigationController(rootViewController: postsVC)
        let navFavorites = UINavigationController(rootViewController: favoritesVC)

        viewControllers = [navPosts, navFavorites]
    }
}
