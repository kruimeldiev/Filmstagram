//
//  NewReviewView.swift
//  Filmstagram
//
//  Created by Casper on 10/05/2022.
//

import SwiftUI

struct NewReviewView: View {
    
    @ObservedObject var viewModel: NewReviewViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 40) {
                Text("New review")
                    .font(.custom(FontKeys.Nunito.semiBold.rawValue, size: 24))
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Review title", text: $viewModel.newReview.title)
                    Divider()
                        .frame(height: 1)
                        .padding(.bottom, 16)
                    TextField("Film title", text: $viewModel.newReview.filmTitle)
                    Divider()
                        .frame(height: 1)
                        .padding(.bottom, 16)
                    TextField("Film director", text: $viewModel.newReview.filmDirector)
                    Divider()
                        .frame(height: 1)
                        .padding(.bottom, 16)
                    TextEditor(text: $viewModel.newReview.reviewText)
                        .frame(height: 200, alignment: .top)
                    Divider()
                        .frame(height: 1)
                }
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                if viewModel.currentlyHandling {
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
                VStack(alignment: .center, spacing: 16) {
                    Button {
                        Task {
                            await viewModel.writeNewReview()
                            if viewModel.successfullUpload { presentationMode.wrappedValue.dismiss() }
                        }
                    } label: {
                        Spacer()
                        Text("Post review")
                            .padding(12)
                            .foregroundColor(.white)
                            .font(.custom(FontKeys.Nunito.medium.rawValue, size: 16))
                        Spacer()
                    }
                    .disabled(viewModel.currentlyHandling)
                    .background(Color(ColorKeys.halfBlack.rawValue))
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(ColorKeys.textGray.rawValue), lineWidth: 1))
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 3)
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Spacer()
                        Text("Cancel")
                            .padding(12)
                            .foregroundColor(Color(ColorKeys.halfBlack.rawValue))
                            .font(.custom(FontKeys.Nunito.medium.rawValue, size: 14))
                        Spacer()
                    }
                }
            }
            .padding(40)
        }
    }
}

struct NewReviewView_Previews: PreviewProvider {
    static var previews: some View {
        NewReviewView(viewModel: .init())
    }
}
