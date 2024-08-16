//
//  FilmReviewView.swift
//  Filmstagram
//
//  Created by Casper on 24/05/2022.
//

import SwiftUI

struct FilmReviewView: View {
    
    @ObservedObject var viewModel: FilmReviewViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.selecedReview.title)
                        .font(.custom(FontKeys.Nunito.semiBold.rawValue, size: 24))
                    HStack(alignment: .center, spacing: 4) {
                        Image(systemName: "calendar")
                        Text(viewModel.selecedReview.writeDate)
                            .font(.custom(FontKeys.Nunito.light.rawValue, size: 16))
                    }
                    .foregroundColor(Color(ColorKeys.oceanBlue.rawValue))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Film: \(viewModel.selecedReview.filmTitle)")
                        .foregroundColor(Color(ColorKeys.halfBlack.rawValue))
                        .font(.custom(FontKeys.Nunito.regular.rawValue, size: 16))
                    Text("Director: \(viewModel.selecedReview.filmDirector)")
                        .foregroundColor(Color(ColorKeys.halfBlack.rawValue))
                        .font(.custom(FontKeys.Nunito.regular.rawValue, size: 16))
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Review author: \(viewModel.selecedReview.authorName)")
                        .foregroundColor(Color(ColorKeys.halfBlack.rawValue))
                        .font(.custom(FontKeys.Nunito.medium.rawValue, size: 14))
                    Text(viewModel.selecedReview.reviewText)
                        .foregroundColor(Color(ColorKeys.halfBlack.rawValue))
                        .font(.custom(FontKeys.Nunito.light.rawValue, size: 16))
                }
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    }
}

struct FilmReviewView_Previews: PreviewProvider {
    static var previews: some View {
        FilmReviewView(viewModel: .init(filmReview: .init(id: "",
                                                          authorName: "Casper",
                                                          filmTitle: "Oceans Eleven",
                                                          filmDirector: "Director name",
                                                          title: "Review title",
                                                          reviewText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                                          imageUrl: "",
                                                          writeDate: "12 May 2022")))
    }
}
