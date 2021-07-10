//
//  DogGramApp.swift
//  DogGram
//
//  Created by yunus olgun on 15.06.2021.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct DogGramApp: App {
    
    init() {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID  //For google sign in
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    GIDSignIn.sharedInstance().handle(url)  // For google sign in
                })
        }
    }
}
