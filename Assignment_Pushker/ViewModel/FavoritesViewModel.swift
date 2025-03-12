//
//  FavoritesViewModel.swift
//  Assignment_Pushker
//
//  Created by Pushker Pandey on 12/03/25.
//

import RxSwift
import RxCocoa
import RealmSwift

class FavoritesViewModel {
    let favorites = BehaviorRelay<[Post]>(value: [])
    let realm = try! Realm()

    func fetchFavorites() {
        let favPosts = realm.objects(PostObject.self) // Fetch saved favorite posts
        let posts = favPosts.map { $0.toPost() } // Convert Realm objects to Post struct
        favorites.accept(Array(posts))
    }
}
