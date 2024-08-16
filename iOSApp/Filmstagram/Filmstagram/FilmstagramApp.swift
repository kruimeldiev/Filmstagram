//
//  FilmstagramApp.swift
//  Filmstagram
//
//  Created by Casper on 26/04/2022.
//

import SwiftUI
import Firebase

@main
struct FilmstagramApp: App {
    
    /// Link the AppDelegate from below to the main SwiftUI class
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    /// The authHanlder listens for the user's login state, when this state changes, the handler acts accordingly by toggling the userIsLoggedIn bool
    @State private var authHandler: AuthStateDidChangeListenerHandle?
    @State private var userIsLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if userIsLoggedIn {
                    HomeView()
                } else {
                    LoginView(viewModel: .init())
                }
            }.onAppear {
                authHandler = Auth.auth().addStateDidChangeListener { auth, user in
                    guard let _ = user else {
                        userIsLoggedIn = false
                        return
                    }
                    userIsLoggedIn = true
                }
            }.onDisappear {
                Auth.auth().removeStateDidChangeListener(authHandler!)
            }
        }
    }
}

/// The AppDelegate can handle different cases for when the app has launched, opend from background, goes to background, etc.
class AppDelegate: NSObject, UIApplicationDelegate {
    
    /// First thing that runs everytime the app launches
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        /// Configure Firebase
        FirebaseApp.configure()
        
        return true
    }
}
