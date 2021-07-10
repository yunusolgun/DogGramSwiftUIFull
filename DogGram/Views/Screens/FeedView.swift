//
//  FeedView.swift
//  DogGram
//
//  Created by yunus olgun on 18.06.2021.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var posts: PostArrayObject
    var title: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack {
                ForEach(posts.dataArray, id: \.self) { post in
                    PostView(post: post, showHeaderAndFooter: true, addheartAnimationToView: true)
                }
            }
        })
        .navigationBarTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedView(posts: PostArrayObject(shuffled: false), title: "Feed Test")
        }
        
    }
}
