//
//  FilmReviewViewModel.swift
//  Filmstagram
//
//  Created by Casper on 24/05/2022.
//

import SwiftUI

@MainActor
class FilmReviewViewModel: ObservableObject {
    
    let selecedReview: Reviews.FilmReview
    
    init(filmReview: Reviews.FilmReview) {
        self.selecedReview = filmReview
    }
}


