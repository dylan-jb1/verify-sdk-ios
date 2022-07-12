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
    
    // MARK: Control events
    
    @IBAction func onCancelClick(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func onRegisterClick(_ sender: UIButton) {
        guard let options = options else {
            buttonRegister.isEnabled = false
            return
        }
        
        // MARK: Metadata UUID
        // The UUID string represents an identifier to the aaguid.  When configured with FIDO metadata, authenticators are validated and provide additional characistics. Refer to the metadata.json in the Sources folder.
        var uuid = "6dc9f22d-2c0a-4461-b878-de61e159ec61"
        if server == isv {
            uuid = "cdbdaea2-c415-5073-50f7-c04e968640b6"
        }
        
        let aaguid = UUID(uuidString: uuid)!
        let provider = PublicKeyCredentialProvider()
        provider.delegate = self
        provider.createCredentialAttestationRequest(aaguid, statementProvider: SelfAttestation(aaguid), options: options)
    }
    
}


