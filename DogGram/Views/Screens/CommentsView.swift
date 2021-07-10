//
//  CommentsView.swift
//  DogGram
//
//  Created by yunus olgun on 18.06.2021.
//

import SwiftUI

struct CommentsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var submissionText: String = ""
    @State var commentArray = [CommentModel]()
    
    var post: PostModel
    
    @State var profilePicture: UIImage = UIImage(named: "logo.loading")!
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentUserDisplayName: String?
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(commentArray, id:\.self) { comment in
                        MessageView(comment: comment)
                    }
                }
                
            }
            
            HStack {
                Image(uiImage: profilePicture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                
                TextField("Add a comment here...", text: $submissionText )
                
                Button(action: {
                    if textIsAppropriate() {
                        addComment()
                    }
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                })
                .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                
                
            }.padding(.all, 6)
        }
        .padding(.horizontal)
        .navigationBarTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            getComments()
            getProfilePicture()
        })
    }
    
    //MARK: FUNCTIONS
    
    func getProfilePicture() {
        
        guard let userID = currentUserID else { return }
        
        ImageManager.instance.downloadProfileImage(userID: userID) { returnedImage in
            if let image = returnedImage {
                self.profilePicture = image
            }
        }
    }
    
    func getComments() {
        /*
        let comment1 = CommentModel(commentID: "", userID: "", username: "Joe Green", content: "This is the first comment", dateCreated: Date())
        let comment2 = CommentModel(commentID: "", userID: "", username: "Alex", content: "This is the second comment", dateCreated: Date())
        let comment3 = CommentModel(commentID: "", userID: "", username: "Stephenie", content: "This is the third comment", dateCreated: Date())
        let comment4 = CommentModel(commentID: "", userID: "", username: "Cris", content: "This is the fourth comment", dateCreated: Date())
        
        self.commentArray.append(comment1)
        self.commentArray.append(comment2)
        self.commentArray.append(comment3)
        self.commentArray.append(comment4)
 */
        
        guard self.commentArray.isEmpty else { return }
        print("GET COMMENTS FROM DATABASE")
        if let caption = post.caption, caption.count > 1 {
            let captionComment = CommentModel(commentID: "", userID: post.userID, username: post.username, content: caption, dateCreated: post.dateCreated)
            self.commentArray.append(captionComment)
        }
        
        DataService.instance.downloadComments(postID: post.postID) { returnedComments in
            self.commentArray.append(contentsOf: returnedComments)
        }
        
    }
    
    func textIsAppropriate() -> Bool {
        // Check if the text has curses
        // Check if the text is long enough
        // Check if the text is blank
        // Check for inappropriate things
        
        // Checking for bad words
        let badWordArray: [String] = ["shit", "ass"]
        
        let words = submissionText.components(separatedBy: " ")
        
        for word in words {
            if badWordArray.contains(word) {
                return false
            }
        }
        
        // Checking for minimum character count
        if submissionText.count < 3 {
            return false
        }
        
        
        return true
        
    }
    
    
    func addComment() {
        
        guard let userID = currentUserID, let displayName = currentUserDisplayName else { return }
        
        DataService.instance.uploadComment(postID: post.postID, content: submissionText, displayName: displayName, userID: userID) { success, returnedCommentID in
            
            if success, let commentID = returnedCommentID {
                let newComment = CommentModel(commentID: commentID, userID: userID, username: displayName, content: submissionText, dateCreated: Date())
                self.commentArray.append(newComment)
                self.submissionText = ""
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        
    }
    
}

struct CommentsView_Previews: PreviewProvider {
    
    static let post = PostModel(postID: "dfd", userID: "dfd", username: "df", dateCreated: Date(), likeCount: 0, likedByUser: false)
    
    static var previews: some View {
        NavigationView {
            CommentsView(post: post)
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
        
    }
}
