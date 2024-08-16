//
//  LoginView.swift
//  Filmstagram
//
//  Created by Casper on 26/04/2022.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 60) {
                Spacer()
                Text("Login")
                    .font(.custom(FontKeys.Nunito.semiBold.rawValue, size: 36))
                VStack(alignment: .leading, spacing: 16) {
                    ApplicationTextField(style: .email, userInput: $viewModel.user.email)
                    ApplicationTextField(style: .password, userInput: $viewModel.user.password)
                }
                VStack(alignment: .center, spacing: 12) {
                    Button {
                        Task {
                            await viewModel.handleLogin()
                        }
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            Spacer()
                            Text("Login")
                                .padding(12)
                                .foregroundColor(.white)
                                .font(.custom(FontKeys.Nunito.medium.rawValue, size: 16))
                            Spacer()
                        }
                        .background(Color(ColorKeys.halfBlack.rawValue))
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(ColorKeys.textGray.rawValue), lineWidth: 1))
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 3)
                    }
                    Text("or")
                        .padding(.top, 8)
                        .foregroundColor(Color(ColorKeys.textGray.rawValue))
                        .font(.custom(FontKeys.Nunito.medium.rawValue, size: 12))
                    NavigationLink {
                        RegisterView(viewModel: .init())
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            Spacer()
                            Text("Register")
                                .padding(12)
                                .foregroundColor(Color(ColorKeys.halfBlack.rawValue))
                                .font(.custom(FontKeys.Nunito.medium.rawValue, size: 14))
                            Spacer()
                        }
                        
                    }
                }
                Spacer()
                Spacer()
            }
            .padding(40)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init())
    }
}
