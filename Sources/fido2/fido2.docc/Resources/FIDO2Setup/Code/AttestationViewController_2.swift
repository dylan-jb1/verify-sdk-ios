//
// Copyright contributors to the IBM Security Verify FIDO2 Sample App for iOS project
//

import UIKit
import LocalAuthentication
import CryptoKit
import os.log
import FIDO2

class AttestationViewController: UIViewController {
    // MARK: Control variables
    @IBOutlet weak var buttonOption: UIButton!
    @IBOutlet weak var labelRp: UILabel!
    @IBOutlet weak var labelAccessToken: UILabel!
    
    // MARK: Variables
    var displayName: String?
    var accessToken: String?
    var rpUrl: String?
    var userName: String?
    var server = isv
    var params: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Apply some styling to the visual controls.
        buttonOption.setCornerRadius()
        
        guard let accessToken = accessToken, let rpUrl = rpUrl else {
            return
        }
        
        labelRp.text = "\(rpUrl)/attestation/options"
        labelAccessToken.text = accessToken
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AttestationInfoViewController, let options = sender as? PublicKeyCredentialCreationOptions {
            viewController.options = options
            viewController.accessToken = accessToken!
            viewController.rpUrl = "\(rpUrl!)"
            viewController.params = self.params
            viewController.username = self.userName
            viewController.displayName = self.displayName
            viewController.server = self.server
            viewController.isModalInPresentation = true
        }
    }
    
}
