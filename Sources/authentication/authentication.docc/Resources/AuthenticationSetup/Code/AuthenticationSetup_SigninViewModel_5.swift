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
    var tokenURL: URL?
    var redirectURL: URL?
    
    let clientSecret = ""
    
    func performSignin(authorizationURL: String, tokenURL: String, redirectURL: String, clientID: String, shareSession: Bool, includeState: Bool) {
        let issuerURL = URL(string: authorizationURL)!
        self.redirectURL = URL(string: redirectURL)!
        self.tokenURL = URL(string: tokenURL)!
        
        let provider = OAuthProvider(clientId: clientID, clientSecret: self.clientSecret)
        provider.delegate = self
        
        provider.authorizeWithBrowser (
            issuer: issuerURL,
            redirectUrl: self.redirectURL!,
            presentingViewController: self,
            state: includeState ? UUID().uuidString : nil,
            shareSession: shareSession
        )
    }
}

// MARK: - ASWebAuthenticationPresentationContextProviding
extension SigninViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}

// MARK: - OAuthProviderDelegate
extension SigninViewModel: OAuthProviderDelegate {
    func oauthProvider(provider: OAuthProvider, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func oauthProvider(provider: OAuthProvider, didCompleteWithCode result: (code: String, state: String?)) {
        
        provider.authorize(issuer: tokenURL!, redirectUrl: self.redirectURL, authorizationCode: result.code, codeVerifier: nil) { result in
         
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    self.token = token
                case .failure(let error):
                    print("error \(error.localizedDescription)")
                }
            }
        }
    }
}

