//
//  UserService.swift
//  Filmstagram
//
//  Created by Casper on 03/05/2022.
//

import SwiftUI
import Firebase

final class UserService {
    
    let fireStore = Firestore.firestore()
    
    @AppStorage(AppStorageKeys.loggedInUser.rawValue) private var userProfileData: Data = Data()
    
    /// Creates a new user in Firebase Auth and then stores the user data in Firestore
    func registerUser(email: String, password: String, username: String) async throws {
        do {
            /// 1. Register in Auth
            let registerResult = try await Auth.auth().createUser(withEmail: email, password: password)
            /// 2. Store data in Firestore
            try await fireStore
                .collection(FirebaseKeys.Collections.users.rawValue)
                .document(registerResult.user.uid)
                .setData([FirebaseKeys.UserDocument.uid.rawValue: registerResult.user.uid,
                          FirebaseKeys.UserDocument.email.rawValue: email,
                          FirebaseKeys.UserDocument.username.rawValue: username])
            /// 3. Create data object from the registered user
            let loggedInUser = Profiles.UserProfile(id: registerResult.user.uid, email: email, name: username)
            /// 4. Store user data in UserDefaults
            userProfileData = try JSONEncoder().encode(loggedInUser)
        } catch {
            // TODO: Error handling
            print("Got an error registering")
            print(error)
            throw error
        }
    }
    
    /// Fetches the currently logged in user from Firestore
    func fetchCurrentUser(id: String) async throws -> Profiles.UserProfile {
        do {
            let document = try await fireStore
                .collection(FirebaseKeys.Collections.users.rawValue)
                .document(id)
                .getDocument()
            
            guard let data = document.data() else { throw AuthenticationError.loginFailed }
            guard let id = data[FirebaseKeys.UserDocument.uid.rawValue] as? String else { throw AuthenticationError.loginFailed }
            guard let email = data[FirebaseKeys.UserDocument.email.rawValue] as? String else { throw AuthenticationError.loginFailed }
            guard let username = data[FirebaseKeys.UserDocument.username.rawValue] as? String else { throw AuthenticationError.loginFailed }
            
            return .init(id: id, email: email, name: username)
        } catch {
            print(error)
            throw error
        }
    }
    
    /// Fetches all the users that have registerred from the Firestore
    func fetchAllOtherUsers(myUsername: String) async throws -> [Profiles.OtherProfile] {
        do {
            /// 1. Get the snapshot
            let snapshot = try await fireStore
                .collection(FirebaseKeys.Collections.users.rawValue)
                .getDocuments()
            /// 2. Create the array to store data
            var returnArray = [Profiles.OtherProfile]()
            /// 3. For loop is used to store all the users into the return array
            for document in snapshot.documents {
                let data = document.data()
                guard let username = data[FirebaseKeys.UserDocument.username.rawValue] as? String else { throw ApplicationError.dataDecodingError }
                returnArray.append(Profiles.OtherProfile(name: username, following: try await checkIfFollowing(myUsername: myUsername,
                                                                                                               otherUsername: username)))
            }
            /// 4. Return the users
            return returnArray
        } catch {
            print(error)
            throw error
        }
    }
    
    /// Used by the fetchAllUsers() call to check which users are initially followed
    private func checkIfFollowing(myUsername: String, otherUsername: String) async throws -> Bool {
        do {
            let document = try await fireStore
                .collection(FirebaseKeys.Collections.userFollowing.rawValue)
                .document("\(myUsername)FOLLOWING\(otherUsername)")
                .getDocument()
            if document.exists { return true } else { return false }
        } catch {
            // TODO: Error handling
            print(error)
            return false
        }
    }
    
    /// Start following a user
    func followNewUser(myUsername: String, usernameToFollow: String) async throws {
        do {
            try await fireStore
                .collection(FirebaseKeys.Collections.userFollowing.rawValue)
                .document("\(myUsername)FOLLOWING\(usernameToFollow)")
                .setData([FirebaseKeys.UserFollowingDocument.username.rawValue: myUsername,
                          FirebaseKeys.UserFollowingDocument.following.rawValue: usernameToFollow])
        } catch {
            // TODO: Error handling
            print(error)
            throw error
        }
    }
    
    /// Stop following a user
    func unfollowUser(myUsername: String, usernameToUnfollow: String) async throws {
        do {
            try await fireStore
                .collection(FirebaseKeys.Collections.userFollowing.rawValue)
                .document("\(myUsername)FOLLOWING\(usernameToUnfollow)")
                .delete()
        } catch {
            // TODO: Error handling
            print(error)
            throw error
        }
    }
    
    func fetchFollowingUsers(myUsername: String) async throws -> [String] {
        do {
            let snapshot = try await fireStore
                .collection(FirebaseKeys.Collections.userFollowing.rawValue)
                .whereField(FirebaseKeys.UserFollowingDocument.username.rawValue, isEqualTo: myUsername)
                .getDocuments()
            var returnArray = [String]()
            for document in snapshot.documents {
                let data = document.data()
                guard let followingUsername = data[FirebaseKeys.UserFollowingDocument.following.rawValue] as? String else { throw ApplicationError.dataDecodingError }
                returnArray.append(followingUsername)
            }
            return returnArray
        } catch {
            // TODO: Error handling
            print(error)
            throw error
        }
    }
}
