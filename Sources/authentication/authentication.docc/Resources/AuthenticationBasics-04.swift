import Authentication
import AuthenticationServices

// The view controller to start user authentication.
class SigninViewController: UIViewController {
    let issuerUrl : URL = URL(string: "https://www.example.com/authorize")!
    let tokenURL : URL = URL(string: "https://www.example.com/token")!
    let redirectUrl : URL = URL(string: "verifysdk://auth/callback")!

    func onSigninClick() {
        let provider = OAuthProvider(clientId: "a1b2c3d4")
        provider.delegate = self
        
        // Pass additional options like state and preserve the browser session if required.
        provider.authorizeWithBrowser(issuer: issuerURL,
            redirectUrl: self.redirectURL,
            presentingViewController: self)
    }
}

// MARK: - ASWebAuthenticationPresentationContextProviding
extension SigninViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}

// MARK: - OAuthProviderDelegate
extension SigninViewController: OAuthProviderDelegate {
    func oauthProvider(provider: OAuthProvider, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }

    func oauthProvider(provider: OAuthProvider, didCompleteWithCode result: (code: String, state: String?)) {
        
        // Exchange the authorization code for an access token.
        provider.authorize(issuer: tokenURL!, redirectUrl: self.redirectURL, authorizationCode: result.code) { result in
         
            switch result {
            case .success(let token):
                print("save \(token)")
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
}