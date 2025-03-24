import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private let realm = try! Realm()

    // Save Posts to Realm
    func savePosts(_ posts: [Post]) {
        try! realm.write {
            let realmPosts = posts.map { PostObject(post: $0) }
            realm.add(realmPosts, update: .all)
        }
    }

    // Fetch Saved Posts
    func getSavedPosts() -> [Post] {
        return realm.objects(PostObject.self).map { $0.toPost() }
    }

    // Check if Post is Favorite
    func isPostFavorite(_ post: Post) -> Bool {
        return realm.object(ofType: PostObject.self, forPrimaryKey: post.id) != nil
    }

    // Add or Remove Favorite Post
    func toggleFavorite(post: Post) {
        try! realm.write {
            if let existingPost = realm.object(ofType: PostObject.self, forPrimaryKey: post.id) {
                realm.delete(existingPost) // Remove favorite
            } else {
                realm.add(PostObject(post: post)) // Add favorite
            }
        }
    }

    // ❌ REMOVE FAVORITE POST (New Method)
    func removeFavorite(post: Post) {
        try! realm.write {
            if let existingPost = realm.object(ofType: PostObject.self, forPrimaryKey: post.id) {
                realm.delete(existingPost)
            }
        }
    }
}
