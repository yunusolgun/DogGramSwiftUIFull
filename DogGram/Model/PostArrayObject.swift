//
//  PostArrayObject.swift
//  DogGram
//
//  Created by yunus olgun on 18.06.2021.
//

import Foundation

class PostArrayObject: ObservableObject {
    @Published var dataArray = [PostModel]()
    
    init() {
        let post1 = PostModel(postID: "", userID: "", username: "Joe Green", caption: "This is a caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post2 = PostModel(postID: "", userID: "", username: "Jessica", caption: nil, dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post3 = PostModel(postID: "", userID: "", username: "Emily", caption: "This is a very very long caption haha haha haha haha haha", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post4 = PostModel(postID: "", userID: "", username: "Christopher", caption: nil, dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        self.dataArray.append(post1)
        self.dataArray.append(post2)
        self.dataArray.append(post3)
        self.dataArray.append(post4)
    }
    
    /// USED FOR SINGLE POST SELECTION
    init(post: PostModel) {
        self.dataArray.append(post)
    }
    
}
