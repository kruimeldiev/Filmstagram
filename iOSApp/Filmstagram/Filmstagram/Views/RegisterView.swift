//
//  RegisterView.swift
//  Filmstagram
//
//  Created by Casper on 26/04/2022.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Spacer()
            Text("Sign up")
                .font(.custom(FontKeys.Nunito.semiBold.rawValue, size: 24))
            VStack(alignment: .leading, spacing: 16) {
                ApplicationTextField(style: .email, userInput: $viewModel.user.email)
                ApplicationTextField(style: .password, userInput: $viewModel.user.password)
                ApplicationTextField(style: .verifyPassword, userInput: $viewModel.user.passwordVerify)
                ApplicationTextField(style: .username, userInput: $viewModel.user.username)
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
            Button {
                Task {
                    await viewModel.handleRegister()
                }
            } label: {
                Spacer()
                Text("Register")
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
            Spacer()
            Spacer()
        }
        .padding(40)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: .init())
    }
}
