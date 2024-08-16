//
//  RegisterModel.swift
//  Filmstagram
//
//  Created by Casper on 01/05/2022.
//

import Foundation

enum AuthModels {
    
    struct LoginUser {
        var email: String
        var password: String
    }
    
    struct RegisterUser {
        var email: String
        var password: String
        var passwordVerify: String
        var username: String
    }
}
