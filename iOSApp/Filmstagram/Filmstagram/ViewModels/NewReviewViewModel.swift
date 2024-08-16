//
//  NewReviewViewModel.swift
//  Filmstagram
//
//  Created by Casper on 10/05/2022.
//

import SwiftUI

@MainActor
class NewReviewViewModel: ObservableObject {
    
    @AppStorage(AppStorageKeys.loggedInUser.rawValue) private var userProfileData: Data = Data()
    
    @Published var newReview = Reviews.FilmReview(id: "",
                                                  authorName: "",
                                                  filmTitle: "",
                                                  filmDirector: "",
                                                  title: "",
                                                  reviewText: "",
                                                  imageUrl: "",
                                                  writeDate: "")
    @Published var successfullUpload = false
    @Published var errorMessage = ""
    @Published var currentlyHandling = false
    
    // TODO: how to handle DI?
    private let reviewService = ReviewService()
    
    func writeNewReview() async {
        /// 1. Data validation
        guard newReview.filmTitle.isValidReviewAndFilmTitle else {
            // TODO: Error handling
            self.errorMessage = "Film title error message"
            return
        }
        guard newReview.filmDirector.isValidReviewAndFilmTitle else {
            // TODO: Error handling
            self.errorMessage = "Film director error message"
            return
        }
        guard newReview.title.isValidReviewAndFilmTitle else {
            // TODO: Error handling
            self.errorMessage = "Error message"
            return
        }
        guard newReview.reviewText.isValidReviewText else {
            // TODO: Error handling
            self.errorMessage = "Desc error message"
            return
        }
        /// 2. Set the rest of the necessary data
        newReview.id = UUID().uuidString
        newReview.authorName = fetchUserProfileFromAppStorage()
        newReview.writeDate = Date.now.ISO8601Format()
        /// 4. Start handling
        currentlyHandling = true
        /// 5. Upload the data
        do {
            try await reviewService.writeReview(review: self.newReview)
            self.currentlyHandling = false
            self.successfullUpload = true
        } catch {
            self.currentlyHandling = false
        }
    }
    
    private func fetchUserProfileFromAppStorage() -> String {
        guard let test = try? JSONDecoder().decode(Profiles.UserProfile.self, from: userProfileData) else { return "nil" }
        return test.name
    }
}
