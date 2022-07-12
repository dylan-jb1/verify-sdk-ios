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
}
