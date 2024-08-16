//
//  SettingsViewModel.swift
//  Filmstagram
//
//  Created by Casper on 10/05/2022.
//

import SwiftUI
import Firebase

@MainActor
class SettingsViewModel: ObservableObject {
    
    @AppStorage(AppStorageKeys.loggedInUser.rawValue) private var userProfileData: Data = Data()
    
    func logoutUser() {
        do {
            /// Logout and remove the user data from UserDefaults
            try Auth.auth().signOut()
            userProfileData = Data()
        } catch {
            // TODO: Error handling
        }
    }
}
