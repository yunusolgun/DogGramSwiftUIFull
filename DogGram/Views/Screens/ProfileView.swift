//
//  ProfileView.swift
//  DogGram
//
//  Created by yunus olgun on 19.06.2021.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var isMyProfile: Bool
    @State var profileDisplayName: String
    var profileUserID: String
    @State var profileBio: String = ""
    
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    
    var posts: PostArrayObject
    
    @State var showSettings: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            ProfileHeaderView(profileDisplayName: $profileDisplayName, profileImage: $profileImage, postArray: posts, profileBio: $profileBio)
            Divider()
            ImageGridView(posts: posts)
        })
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    showSettings.toggle()
                                }, label: {
                                    Image(systemName: "line.horizontal.3")
                                })
                                .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                                .opacity(isMyProfile ? 1.0 : 0.0)
        )
        .onAppear(perform: {
           getProfileImage()
            getAdditionalProfileInfo()
        })
        .sheet(isPresented: $showSettings, content: {
            SettingsView(userDisplayName: $profileDisplayName, userBio: $profileBio, userProfilePicture: $profileImage)
                .preferredColorScheme(colorScheme)
        })
    }
    
    // MARK: FUNCTIONS
    
    func getProfileImage() {
        ImageManager.instance.downloadProfileImage(userID: profileUserID) { returnedImage in
            
            if let image = returnedImage {
                self.profileImage = image
            }
        }
    }
    
    
    func getAdditionalProfileInfo() {
        AuthService.instance.getUserInfo(forUserID: profileUserID) { returnedDisplayName, returnedBio in
            if let displayName = returnedDisplayName {
                self.profileDisplayName = displayName
            }
            
            if let bio = returnedBio {
                self.profileBio = bio
            }
        }
    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(isMyProfile: true, profileDisplayName: "Joe", profileUserID: "", posts: PostArrayObject(userID: ""))
                .preferredColorScheme(.light)
        }
    }
}
