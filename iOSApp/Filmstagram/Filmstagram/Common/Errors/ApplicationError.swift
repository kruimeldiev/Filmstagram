//
//  ApplicationError.swift
//  Filmstagram
//
//  Created by Casper on 13/05/2022.
//

import Foundation

enum ApplicationError: Error {
    
    case genericError
    
    case dataDecodingError
    
    var description: String {
        switch self {
            case .genericError:
                return "An unknown error occured"
            case .dataDecodingError:
                return "Unable to decode data from Firestore"
        }
    }
    
}
