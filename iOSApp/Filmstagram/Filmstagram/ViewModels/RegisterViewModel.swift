//
//  RegisterViewModel.swift
//  Filmstagram
//
//  Created by Casper on 03/05/2022.
//

import SwiftUI
import Firebase

@MainActor
class RegisterViewModel: ObservableObject {
    
    @Published var user = AuthModels.RegisterUser(email: "",
                                                  password: "",
                                                  passwordVerify: "",
                                                  username: "")
    @Published var errorMessage = ""
    @Published var currentlyHandling = false
    
    // TODO: Not the right setup i think
    private let userService = UserService()
    
    func handleRegister() async {
        /// 1. Validate the data
        guard user.email.isValidEmail else {
            self.errorMessage = AuthenticationError.registrationInvalidEmail.description
            return
        }
        guard user.password.isValidPassword && user.password == user.passwordVerify else {
            self.errorMessage = AuthenticationError.registrationInvalidPassword.description
            return
        }
        guard user.username.isValidUsername else {
            self.errorMessage = AuthenticationError.registrationInvalidUsername.description
            return
        }
        /// 2. Start handling
        currentlyHandling = true
        do {
            /// 3. Register user
            try await userService.registerUser(email: user.email, password: user.password, username: user.username)
            self.currentlyHandling = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.currentlyHandling = false
        }
    }
}
