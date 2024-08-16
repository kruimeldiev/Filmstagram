//
//  OtherProfileCell.swift
//  Filmstagram
//
//  Created by Casper on 27/05/2022.
//

import SwiftUI

struct OtherProfileCell: View {
    
    @State var profile: Profiles.OtherProfile
    var userDidTapHeart: () -> Void
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            Text(profile.name)
                .font(.custom(FontKeys.Nunito.regular.rawValue, size: 18))
                .foregroundColor(Color(ColorKeys.halfBlack.rawValue))
            
            Spacer()
            
            Button {
                userDidTapHeart()
                profile.following.toggle()
            } label: {
                Image(systemName: profile.following ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, alignment: .center)
                    .foregroundColor(Color(ColorKeys.oceanBlue.rawValue))
            }
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

struct OtherProfileCell_Previews: PreviewProvider {
    
    static var previews: some View {
        OtherProfileCell(profile: .init(name: "username", following: false)) {
            print("Follow")
        }
    }
}
