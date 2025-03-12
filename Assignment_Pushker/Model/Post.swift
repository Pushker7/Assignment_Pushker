//
//  Post.swift
//  Assignment_Pushker
//
//  Created by Pushker Pandey on 12/03/25.
//

import Foundation
import RealmSwift

// Model conforming to Decodable for API response
struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

// Realm Model for Offline Storage
class PostObject: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var userId: Int
    @Persisted var title: String
    @Persisted var body: String

    // Convert Realm Object to Struct
    func toPost() -> Post {
        return Post(id: id, userId: userId, title: title, body: body)
    }

    // Initialize from Post Struct
    convenience init(post: Post) {
        self.init()
        self.id = post.id
        self.userId = post.userId
        self.title = post.title
        self.body = post.body
    }
}
