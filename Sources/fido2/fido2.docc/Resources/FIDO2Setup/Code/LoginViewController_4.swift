//
// Copyright contributors to the IBM Security Verify FIDO2 Sample App for iOS project
//

import UIKit
import os.log
import FIDO2

class LoginViewController: UIViewController {
    // MARK: Control variables
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var textfieldTenant: UITextField!
    @IBOutlet weak var textfieldUsername: UITextField!
    @IBOutlet weak var textfieldClientId: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    
    // MARK: Variable
    var accessToken: String?
    var rpUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set styling
        textfieldPassword.setBorderBottom()
        textfieldTenant.setBorderBottom()
        textfieldUsername.setBorderBottom()
        textfieldClientId.setBorderBottom()
        buttonLogin.setCornerRadius()
        
        // Handle UITextField events
        textfieldTenant.delegate = self
        textfieldUsername.delegate = self
        textfieldPassword.delegate = self
        textfieldClientId.delegate = self
        
        textfieldTenant.becomeFirstResponder()
    }
    
    // MARK: Control events
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AttestationViewController {
            viewController.accessToken = accessToken!
            viewController.rpUrl = rpUrl!
            viewController.server = isv
            viewController.userName = textfieldUsername.text!
            viewController.params = ["authenticatorSelection": ["requireResidentKey":true]]
            viewController.isModalInPresentation = true
        }
    }
    
    @IBAction func onLogin(_ sender: UIButton) {
        // Validate before submitting.
        guard let tenantUrl = textfieldTenant.text, !tenantUrl.isEmpty, let clientId = textfieldClientId.text, !clientId.isEmpty, let username = textfieldUsername.text, !username.isEmpty, let password = textfieldPassword.text, !password.isEmpty else {
            let alertController = UIAlertController(title: "FIDO2 Example", message: "Please enter all fields.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alertController, animated: true)
            return
        }
        
        buttonLogin.setActivity(true)
        
        // Perform the login attempt.
        login(url: tenantUrl, clientId: clientId, username: username, password: password) {
            result in
            
            switch result {
            case .failure(let error):
                self.buttonLogin.setActivity(false)
                Logger.app.debug("Login error. \(error.localizedDescription)")

                let alertController = UIAlertController(title: "FIDO2 Example", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                DispatchQueue.main.async {
                    self.present(alertController, animated: true)
                }
            case .success(let value):
                self.accessToken = value
                
                self.fidoRegistration(url: tenantUrl, accessToken: value) { result in
                    self.buttonLogin.setActivity(false)
                    
                    switch result {
                    case .failure(let error):
                        Logger.app.debug("Login error. \(error.localizedDescription)")

                        let alertController = UIAlertController(title: "FIDO2 Example", message: error.localizedDescription, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        DispatchQueue.main.async {
                            self.present(alertController, animated: true)
                        }
                    case .success(let value):
                        // Create the replying party string.
                        self.rpUrl = self.createRelyingPartyUrl(baseUrl: tenantUrl, registrationId: value)
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "ShowAttestation", sender: nil)
                        }
                    }
                }
            }
        }
    }
}
