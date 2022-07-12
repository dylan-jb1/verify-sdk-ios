//
// Copyright contributors to the IBM Security Verify FIDO2 Sample App for iOS project
//

import Foundation
import UIKit
import CryptoKit
import os.log
import FIDO2

class AttestationInfoViewController: UIViewController {
    // MARK: Control variables
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var textfieldNickname: UITextField!
    
    // MARK: Variables
    var options: PublicKeyCredentialCreationOptions? = nil
    var accessToken: String? = nil
    var username: String? = nil
    var displayName: String? = nil
    var rpUrl: String? = nil
    var server = isv
    var params: [String: Any] = [:]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Apply some styling to the visual controls.
        textfieldNickname.setBorderBottom()
        textfieldNickname.becomeFirstResponder()
        
        buttonRegister.setCornerRadius()
                        
        // Hides the keyboard
        textfieldNickname.delegate = self
    }
    
}
