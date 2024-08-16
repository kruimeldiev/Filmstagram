//
//  String + Validate.swift
//  Filmstagram
//
//  Created by Casper on 26/04/2022.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}").evaluate(with: self)
    }
    
    var isValidUsername: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[a-zA-Z0-9]{4,18}").evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        NSPredicate(format: "SELF MATCHES %@", "\\w{7,18}").evaluate(with: self)
    }
    
    var isValidReviewAndFilmTitle: Bool {
        (self.count >= 4) && (self.count <= 64)
    }
    
    var isValidReviewText: Bool {
        (self.count >= 12) && (self.count <= 20480)
    }
}
