//
//  Profiles.swift
//  Filmstagram
//
//  Created by Casper on 03/05/2022.
//

import Foundation

enum Profiles {
    
    struct UserProfile: Codable {
        let id: String
        let email: String
        let name: String
    }
    
    struct OtherProfile: Codable, Identifiable {
        var id = UUID()
        let name: String
        var following: Bool = false
    }
}
