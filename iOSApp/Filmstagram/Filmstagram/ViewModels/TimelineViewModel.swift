//
//  TimelineViewModel.swift
//  Filmstagram
//
//  Created by Casper on 10/05/2022.
//

import SwiftUI

@MainActor
class TimelineViewModel: ObservableObject {
    
    @AppStorage(AppStorageKeys.loggedInUser.rawValue) private var userProfileData: Data = Data()
    @Published var userProfile = Profiles.UserProfile(id: "", email: "nil", name: "nil")
    
    @Published var myTimelineItems = [Reviews.FilmReview]()
    
    /// This bool indicates if we should show the NewReviewView
    @Published var showingNewReviewSheet = false
    
    /// Array of usernames that the logged in user follows
    private var following = [String]()
    
    private let reviewService = ReviewService()
    private let userService = UserService()
    
    func fetchTimeline() async {
        /// 1. Fetch the data for the currently logged in user
        guard let profile = try? JSONDecoder().decode(Profiles.UserProfile.self, from: userProfileData) else { return }
        self.userProfile = profile
        /// 2. Start async block
        do {
            /// 3. Fetch a list of following accounts
            following = try await userService.fetchFollowingUsers(myUsername: userProfile.name)
            /// 4. Fetch the reviews that my following list have posted
            myTimelineItems = try await reviewService.fetchReviews(following: following)
        } catch {
            // TODO: Error handling
            print(error)
        }
    }
}
