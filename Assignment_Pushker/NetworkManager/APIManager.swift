//
//  APIManager.swift
//  Assignment_Pushker
//
//  Created by Pushker Pandey on 12/03/25.
//

import Alamofire
import RxSwift

class APIManager {
    static let shared = APIManager()

    func fetchPosts() -> Observable<[Post]> {
        return Observable.create { observer in
            AF.request("https://jsonplaceholder.typicode.com/posts").responseDecodable(of: [Post].self) { response in
                switch response.result {
                case .success(let posts):
                    observer.onNext(posts)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
