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
                Image("dog1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                
                TextField("Add a comment here...", text: $submissionText )
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
        })
    }
    
    //MARK: Functions
    
    func getComments() {
        let comment1 = CommentModel(commentID: "", userID: "", username: "Joe Green", content: "This is the first comment", dateCreated: Date())
        let comment2 = CommentModel(commentID: "", userID: "", username: "Alex", content: "This is the second comment", dateCreated: Date())
        let comment3 = CommentModel(commentID: "", userID: "", username: "Stephenie", content: "This is the third comment", dateCreated: Date())
        let comment4 = CommentModel(commentID: "", userID: "", username: "Cris", content: "This is the fourth comment", dateCreated: Date())
        
        self.commentArray.append(comment1)
        self.commentArray.append(comment2)
        self.commentArray.append(comment3)
        self.commentArray.append(comment4)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CommentsView()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
        
    }
}
