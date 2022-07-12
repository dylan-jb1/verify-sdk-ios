//
// Copyright contributors to the IBM Security Verify FIDO2 Sample App for iOS project
//

import UIKit

class WhoAmIViewController: UIViewController {
    // MARK: Control variables
    @IBOutlet weak var textfieldRp: UITextField!
    @IBOutlet weak var textfieldAccessToken: UITextField!
    @IBOutlet weak var buttonWhoAmI: UIButton!
    
    // MARK: Variable
    var accessToken: String?
    var rpUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set styling
        textfieldRp.setBorderBottom()
        textfieldAccessToken.setBorderBottom()
        buttonWhoAmI.setCornerRadius()
        
        // Handle UITextField events
        textfieldRp.delegate = self
        textfieldAccessToken.delegate = self
        
        textfieldRp.becomeFirstResponder()
    }
    
    // MARK: Control events
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AttestationViewController, let ivcreds = sender as? IVCreds {
            viewController.accessToken = textfieldAccessToken.text!
            viewController.rpUrl = textfieldRp.text!
            viewController.displayName = ivcreds.attributes!["name"] as? String
            viewController.userName = ivcreds.username
            viewController.server = isva
            viewController.isModalInPresentation = true
        }
    }
    
}
