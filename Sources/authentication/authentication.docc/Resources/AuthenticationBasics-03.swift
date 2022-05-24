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