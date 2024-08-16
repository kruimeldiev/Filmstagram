//
//  ProfileViewModel.swift
//  Filmstagram
//
//  Created by Casper on 10/05/2022.
//

import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    
    @AppStorage(AppStorageKeys.loggedInUser.rawValue) private var userProfileData: Data = Data()
    @Published var userProfile = Profiles.UserProfile(id: "", email: "nil", name: "nil")
    @Published var otherProfiles = [Profiles.OtherProfile]()
    
    private let userService = UserService()
    
    func fetchUserProfileFromAppStorage() {
        guard let profile = try? JSONDecoder().decode(Profiles.UserProfile.self, from: userProfileData) else { return }
        self.userProfile = profile
    }
    
    func fetchOtherProfiles() async throws {
        do {
            otherProfiles = try await userService.fetchAllOtherUsers(myUsername: userProfile.name)
        } catch {
            // TODO: Error handling
            print(error)
        }
    }
    
    func handleHeartButtonTapped(user: Int) async {
        let alreadyFollowingUser = otherProfiles[user].following
        let otherProfileUsername = self.otherProfiles[user].name
        do {
            if alreadyFollowingUser {
                try await userService.unfollowUser(myUsername: userProfile.name, usernameToUnfollow: otherProfileUsername)
                self.otherProfiles[user].following = false
            } else {
                try await userService.followNewUser(myUsername: userProfile.name, usernameToFollow: otherProfileUsername)
                self.otherProfiles[user].following = true
            }
        } catch {
            // TODO: Error handling
            print(error)
        }
    }
}
