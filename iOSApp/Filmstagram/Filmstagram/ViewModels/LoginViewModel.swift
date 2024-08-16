//
//  LoginViewModel.swift
//  Filmstagram
//
//  Created by Casper on 03/05/2022.
//

import SwiftUI
import Firebase

@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var user = AuthModels.LoginUser(email: "", password: "")
    @Published var errorMessage = ""
    @Published var currentlyHandling = false
    
    /// Properties with the @AppStorage propety wrapper are stored in UserDefaults
    @AppStorage(AppStorageKeys.loggedInUser.rawValue) private var userProfileData: Data = Data()
    
    private let userService = UserService()
    
    func handleLogin() async {
        /// 0. Start handling
        currentlyHandling = true
        do {
            /// 1. Login the user
            let result = try await Auth.auth().signIn(withEmail: user.email, password: user.password)
            /// 2. Fetch the user data from FireStore
            let loggedInUser = try await userService.fetchCurrentUser(id: result.user.uid)
            /// 3. Encode user into data and store in AppStorage
            userProfileData = try JSONEncoder().encode(loggedInUser)
            /// 4. Finish handling
            self.currentlyHandling = false
        } catch {
            // TODO: Error handling
            self.currentlyHandling = false
            print("Login error: ", error)
        }
    }
}
