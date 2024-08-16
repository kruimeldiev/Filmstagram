//
//  TimelineCell.swift
//  Filmstagram
//
//  Created by Casper on 10/05/2022.
//

import SwiftUI

struct TimelineCell: View {
    
    var review: Reviews.FilmReview
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            
            Text(review.title)
                .font(.custom(FontKeys.Nunito.medium.rawValue, size: 18))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(ColorKeys.halfBlack.rawValue))
            Text(review.authorName)
                .font(.custom(FontKeys.Nunito.regular.rawValue, size: 14))
                .foregroundColor(Color(ColorKeys.halfBlack.rawValue))
            Text(review.writeDate)
                .font(.custom(FontKeys.Nunito.lightItalic.rawValue, size: 10))
                .foregroundColor(Color(ColorKeys.textGray.rawValue))
            
        }
        .frame(width: UIScreen.main.bounds.width - 80, alignment: .leading)
        .padding()
        .background(.white)
        .overlay(RoundedRectangle(cornerRadius: 12)
            .stroke(Color(ColorKeys.textGray.rawValue).opacity(0.3), lineWidth: 1))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.05), radius: 3, x: 0, y: 3)
        
    }
}

struct TimelineCell_Previews: PreviewProvider {
    static var previews: some View {
        TimelineCell(review: .init(id: "",
                                   authorName: "Casper",
                                   filmTitle: "Film naam",
                                   filmDirector: "Director naam",
                                   title: "Naam",
                                   reviewText: "Beschrijving",
                                   imageUrl: "",
                                   writeDate: ""))
    }
}
