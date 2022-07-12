//
// Copyright contributors to the IBM Security Verify FIDO2 Sample App for iOS project
//

import Foundation
import UIKit
import os.log
import FIDO2

class AssertionInfoViewController: UIViewController {
    // MARK: Control variables
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var stackviewProperties: UIStackView!
    @IBOutlet weak var labelProgress: UILabel!
    
    // MARK: Variables
    var assertion: PublicKeyCredential<AuthenticatorAssertionResponse>?
    var success = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        
        let relyingPartyUrl = UserDefaults.standard.string(forKey: Store.relyingPartyUrl.rawValue)!
        let accessToken = UserDefaults.standard.string(forKey: Store.accessToken.rawValue)!
        let username = UserDefaults.standard.string(forKey: Store.username.rawValue) ?? ""
        
        let assertionUrl = "\(relyingPartyUrl)/assertion/result"
        
        // Perform the authentication
        if let server = UserDefaults.standard.string(forKey: Store.server.rawValue) {
            if server == isva {
                FidoService.shared.assertAuthenticator(assertionUrl, accessToken: accessToken, username: username, assertion: assertion!, type: ISVAAssertionResponse.self) { result in
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.labelProgress.isHidden = true
                    }
                    
                    switch result {
                    case .success(let response):
                        Logger.app.info("Authenticator successfully signed!")
                        self.success = true
                        
                        DispatchQueue.main.async {
                            self.displayCredentialProperties(userData: response)
                        }
                                
                    case .failure(let error):
                        let alertController = UIAlertController(title: "FIDO2 Example", message: error.localizedDescription, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "unwindToAssertionView", sender: self)
                            }
                        }))

                        DispatchQueue.main.async {
                            self.present(alertController, animated: true)
                        }
                    }
                }
            }
            else {
                FidoService.shared.assertAuthenticator(assertionUrl, accessToken: accessToken, username: username, assertion: assertion!, type: ISVAssertionResponse.self) { result in
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.labelProgress.isHidden = true
                    }
                    
                    switch result {
                    case .success(let response):
                        Logger.app.info("Authenticator successfully signed!")
                        self.success = true
                        
                        DispatchQueue.main.async {
                            self.displayCredentialProperties(userData: response)
                        }
                                
                    case .failure(let error):
                        let alertController = UIAlertController(title: "FIDO2 Example", message: error.localizedDescription, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "unwindToAssertionView", sender: self)
                            }
                        }))

                        DispatchQueue.main.async {
                            self.present(alertController, animated: true)
                        }
                    }
                }
            }
        }
    }
}
