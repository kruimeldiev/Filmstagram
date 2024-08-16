//
//  ReviewService.swift
//  Filmstagram
//
//  Created by Casper on 10/05/2022.
//

import Foundation
import Firebase

final class ReviewService {
    
    let fireStore = Firestore.firestore()
    
    /// Stores a new review in Firestore
    func writeReview(review: Reviews.FilmReview) async throws {
        do {
            try await fireStore
                .collection(FirebaseKeys.Collections.reviews.rawValue)
                .document(review.id)
                .setData([FirebaseKeys.ReviewDocument.uid.rawValue: review.id,
                          FirebaseKeys.ReviewDocument.authorName.rawValue: review.authorName,
                          FirebaseKeys.ReviewDocument.filmTitle.rawValue: review.filmTitle,
                          FirebaseKeys.ReviewDocument.filmDirector.rawValue: review.filmDirector,
                          FirebaseKeys.ReviewDocument.title.rawValue: review.title,
                          FirebaseKeys.ReviewDocument.reviewText.rawValue: review.reviewText,
                          FirebaseKeys.ReviewDocument.writeDate.rawValue: review.writeDate,
                          FirebaseKeys.ReviewDocument.imageUrl.rawValue: review.imageUrl])
        } catch {
            throw error
        }
    }
    
    /// Fetches reviews to display in the timeline
    func fetchReviews(following: [String]) async throws -> [Reviews.FilmReview] {
        guard !following.isEmpty else { return [] }
        do {
            let snapshot = try await fireStore
                .collection(FirebaseKeys.Collections.reviews.rawValue)
                .whereField(FirebaseKeys.ReviewDocument.authorName.rawValue, in: following)
                .getDocuments()
            
            var returnArray = [Reviews.FilmReview]()
            for document in snapshot.documents {
                let data = document.data()
                guard let uid = data[FirebaseKeys.ReviewDocument.uid.rawValue] as? String,
                      let authorName = data[FirebaseKeys.ReviewDocument.authorName.rawValue] as? String,
                      let filmTitle = data[FirebaseKeys.ReviewDocument.filmTitle.rawValue] as? String,
                      let filmDirector = data[FirebaseKeys.ReviewDocument.filmDirector.rawValue] as? String,
                      let title = data[FirebaseKeys.ReviewDocument.title.rawValue] as? String,
                      let reviewText = data[FirebaseKeys.ReviewDocument.reviewText.rawValue] as? String,
                      let imageUrl = data[FirebaseKeys.ReviewDocument.imageUrl.rawValue] as? String,
                      let writeDate = data[FirebaseKeys.ReviewDocument.writeDate.rawValue] as? String else { throw ApplicationError.dataDecodingError }
                returnArray.append(Reviews.FilmReview(id: uid,
                                                      authorName: authorName,
                                                      filmTitle: filmTitle,
                                                      filmDirector: filmDirector,
                                                      title: title,
                                                      reviewText: reviewText,
                                                      imageUrl: imageUrl,
                                                      writeDate: writeDate))
            }
            return returnArray
        } catch {
            throw error
        }
    }
}
