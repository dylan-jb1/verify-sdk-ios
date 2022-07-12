//
//  AuthenticationSetup_SigninViewModel_1.swift
//  
//
//  Created by Dylan Bowler on 31/5/2022.
//

import Foundation
import Authentication
import AuthenticationServices

class SigninViewModel: NSObject, ObservableObject {
    @Published var token: TokenInfo?
    var codeVerifier: String? = nil
    var codeChallenge: String? = nil
    var tokenURL: URL?
    var redirectURL: URL?
    
    let clientSecret = ""
}
