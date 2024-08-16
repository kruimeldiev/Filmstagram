//
//  ApplicationTextField.swift
//  Filmstagram
//
//  Created by Casper on 03/05/2022.
//

import SwiftUI

struct ApplicationTextField: View {
    
    var style: ApplicationTextFieldStyle
    
    @Binding var userInput: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: style.imageName)
                .foregroundColor(Color(ColorKeys.textGray.rawValue))
                .frame(width: 18, height: 18, alignment: .center)
                .padding(4)
            switch style {
                case .email:
                    TextField(style.title, text: $userInput)
                        .keyboardType(.emailAddress)
                        .font(.custom(FontKeys.Nunito.light.rawValue, size: 16))
                case .password, .verifyPassword:
                    SecureField(style.title, text: $userInput)
                        .font(.custom(FontKeys.Nunito.light.rawValue, size: 16))
                case .username:
                    TextField(style.title, text: $userInput)
                        .font(.custom(FontKeys.Nunito.light.rawValue, size: 16))
            }
        }
        .padding(12)
        .background(.white)
        .overlay(RoundedRectangle(cornerRadius: 12)
            .stroke(Color.init(ColorKeys.textGray.rawValue), lineWidth: 1))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 3)
    }
}

enum ApplicationTextFieldStyle {
    
    case email
    case password
    case verifyPassword
    case username
    
    var title: String {
        switch self {
            case .email:
                return "Email address"
            case .password:
                return "Password"
            case .verifyPassword:
                return "Verify password"
            case .username:
                return "Username"
        }
    }
    
    var imageName: String {
        switch self {
            case .email:
                return "envelope"
            case .password, .verifyPassword:
                return "key"
            case .username:
                return "person"
        }
    }
}
