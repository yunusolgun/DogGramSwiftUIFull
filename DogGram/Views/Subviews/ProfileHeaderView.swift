//
//  ProfileHeaderView.swift
//  DogGram
//
//  Created by yunus olgun on 19.06.2021.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @Binding var profileDisplayName: String
    @Binding var profileImage: UIImage
    @ObservedObject var postArray: PostArrayObject
    @Binding var profileBio: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10, content: {
            
            //MARK: PROFILE PICTURE
            Image(uiImage: profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120, alignment: .center)
                .cornerRadius(60)
            
            //MARK: USERNAME
            Text(profileDisplayName)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            //MARK: BIO
            if profileBio != "" {
                Text(profileBio)
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }

            
            HStack(alignment: .center, spacing: 20, content: {
                
                //MARK: POSTS
                VStack(alignment: .center, spacing: 5, content: {
                    Text(postArray.postCountString)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: .center)
                    
                    Text("Posts")
                        .font(.callout)
                        .fontWeight(.medium)
                })
                
                //MARK: LIKES
                VStack(alignment: .center, spacing: 5, content: {
                    Text(postArray.likeCountString)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: .center)
                    
                    Text("Likes")
                        .font(.callout)
                        .fontWeight(.medium)
                })
                
            })
            
        })
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    
    @State static var name: String = "Joe"
    @State static var image: UIImage = UIImage(named: "dog1")!
    
    static var previews: some View {
        ProfileHeaderView(profileDisplayName: $name, profileImage: $image, postArray: PostArrayObject(shuffled: false), profileBio: $name)
            .previewLayout(.sizeThatFits)
    }
}
