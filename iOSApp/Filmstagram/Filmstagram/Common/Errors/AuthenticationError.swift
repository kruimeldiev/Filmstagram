//
//  AuthenticationError.swift
//  Filmstagram
//
//  Created by Casper on 01/05/2022.
//

import Foundation

enum AuthenticationError: Error {
    
    case genericError
    
    case loginFailed
    
    case registrationInvalidEmail
    case registrationInvalidPassword
    case registrationInvalidUsername
    
    var description: String {
        switch self {
            case .genericError:
                return "An unknown error occured"
            case .loginFailed:
                return "Login has failed"
            case .registrationInvalidEmail:
                return "Email address is invalid"
            case .registrationInvalidPassword:
                return "Password is invalid"
            case .registrationInvalidUsername:
                return "Invalid username"
        }
    }
}
