//
//  ProfileView.swift
//  Filmstagram
//
//  Created by Casper on 10/05/2022.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(viewModel.userProfile.name)
                        .font(.custom(FontKeys.Nunito.light.rawValue, size: 24))
                    Text(viewModel.userProfile.email)
                        .font(.custom(FontKeys.Nunito.light.rawValue, size: 18))
                }
                .padding(.vertical, 20)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Other profiles")
                        .font(.custom(FontKeys.Nunito.regular.rawValue, size: 24))
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(0..<viewModel.otherProfiles.count, id: \.self) { profileItem in
                            OtherProfileCell(profile: viewModel.otherProfiles[profileItem]) {
                                Task {
                                    await viewModel.handleHeartButtonTapped(user: profileItem)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("My profile")
        }
        .navigationViewStyle(.stack)
        .onAppear {
            viewModel.fetchUserProfileFromAppStorage()
            Task {
                try await viewModel.fetchOtherProfiles()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: .init())
    }
}
