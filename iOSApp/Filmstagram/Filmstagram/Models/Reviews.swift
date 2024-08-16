//
//  Reviews.swift
//  Filmstagram
//
//  Created by Casper on 10/05/2022.
//

import Foundation

enum Reviews {
    
    struct FilmReview: Hashable, Identifiable {
        var id: String
        var authorName: String
        var filmTitle: String
        var filmDirector: String
        var title: String
        var reviewText: String
        var imageUrl: String
        var writeDate: String
    }
}
