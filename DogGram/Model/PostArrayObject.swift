//
//  PostArrayObject.swift
//  DogGram
//
//  Created by yunus olgun on 18.06.2021.
//

import Foundation

class PostArrayObject: ObservableObject {
    @Published var dataArray = [PostModel]()
    @Published var postCountString = "0"
    @Published var likeCountString = "0"
    
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
    
    
    /// USED FOR GETTING POSTS FOR USER PROFILE
    init(userID: String) {
        
        print("GET POSTS FOR USER ID \(userID)")
        
        DataService.instance.downloadPostForUser(userID: userID) { returnedPosts in
                     
            let sortedPosts = returnedPosts.sorted { post1, post2 in
                return post1.dateCreated > post2.dateCreated
            }
            self.dataArray.append(contentsOf: sortedPosts)
            self.updateCounts()
        }
    }
    
    
    /// USED FOR FEED
    init(shuffled: Bool) {
        
        print("GET POSTS FOR FEED. SHUFFLED: \(shuffled)")
        DataService.instance.downloadPostsForFeed { returnedPosts in
            if shuffled {
                let shufflePosts = returnedPosts.shuffled()
                self.dataArray.append(contentsOf: shufflePosts)
            } else {
                self.dataArray.append(contentsOf: returnedPosts)
            }
        }
    }
    
    
    func updateCounts() {
        
        //post count
        self.postCountString = "\(self.dataArray.count)"
        
        //like count
        let likeCountArray = dataArray.map { existingPost in
            return existingPost.likeCount
        }
        let sumOfLikeCountArray = likeCountArray.reduce(0, +)
        self.likeCountString = "\(sumOfLikeCountArray)"
    }
    
    
}
