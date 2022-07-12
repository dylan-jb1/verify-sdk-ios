//
// Copyright contributors to the IBM Security Verify FIDO2 Sample App for iOS project
//

import UIKit
import os.log
import LocalAuthentication
import FIDO2

// MARK: Constants
let bundleIdentifier = Bundle.main.bundleIdentifier!
let isva = "isva"
let isv = "isv"

// MARK: Enums
enum Store: String {
    case relyingPartyUrl
    case nickname
    case displayName
    case username
    case accessToken
    case createdDate
    case created
    case server
}

enum NetworkError: Error, LocalizedError {
    /// Invalid or format of URL is incorrect.
    case badURL
    
    /// Invalid or no data returned from the serve
    case invalidData
    
    /// General error with custom message.
    case general(message: String)
    
    public var errorDescription: String? {
       switch self {
       case .badURL:
           return NSLocalizedString("Invalid or format of URL is incorrect.", comment: "Invalid URL")
       case .invalidData:
           return NSLocalizedString("Invalid or no data returned from the server.", comment: "Invalid Data")
       case .general(message: let message):
           return NSLocalizedString(message, comment: "General Error")
       }
   }
}

// MARK: Functions

// MARK: Extensions
