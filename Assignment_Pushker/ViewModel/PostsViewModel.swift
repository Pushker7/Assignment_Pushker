//
//  PostsViewModel.swift
//  Assignment_Pushker
//
//  Created by Pushker Pandey on 12/03/25.
//

import RxSwift
import RxCocoa
import RealmSwift

import Alamofire
import RxSwift

class PostsViewModel {
    let posts = PublishSubject<[Post]>()

    func fetchPosts() {
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: [Post].self) { response in
                switch response.result {
                case .success(let posts):
                    self.posts.onNext(posts)
                    RealmManager.shared.savePosts(posts) // Save to Realm
                case .failure(let error):
                    print("Error fetching posts: \(error.localizedDescription)")
                }
            }
    }
}

