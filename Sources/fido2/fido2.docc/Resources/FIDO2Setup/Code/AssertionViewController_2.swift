//
// Copyright contributors to the IBM Security Verify FIDO2 Sample App for iOS project
//

import Foundation
import UIKit
import FIDO2
import CryptoKit

class AssertionViewController: UIViewController {
    // MARK: Control variables
    @IBOutlet weak var buttonAuthenticate: UIButton!
    @IBOutlet weak var buttonRemove: UIButton!
    @IBOutlet weak var labelDisplayName: UILabel!
    @IBOutlet weak var labelHostName: UILabel!
    @IBOutlet weak var labelNickName: UILabel!
    @IBOutlet weak var labelCreatedDate: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var switchEauthExt: UISwitch!
    
    // Random messages for the user to acknowledge before signing the assertion.
    let reasons = ["Please confirm your pizza order of $49.99",
                   "Please verify that you intended to transfer $2,877.34.",
                   "Please confirm you purchased a new Apple MacBook.",
                   "Are you trying to access to the server room?",
                   "Your confirmation of to access the registration resource on this server is required.",
                   "Please confirm your order of 10 widgets."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        // Populate the stored values.
        if let value = UserDefaults.standard.string(forKey: Store.relyingPartyUrl.rawValue), let url = URL(string: value), let hostname = url.host {
            labelHostName.text = hostname
        }
        
        if let value = UserDefaults.standard.string(forKey: Store.nickname.rawValue) {
            labelNickName.text = value
        }
        
        if let value = UserDefaults.standard.string(forKey: Store.displayName.rawValue) {
            labelDisplayName.text = value
        }
        
        if let value = UserDefaults.standard.string(forKey: Store.createdDate.rawValue) {
            labelCreatedDate.text = value
        }
        
        // Animate the registration logo
        setTraitAppearance()
        animateLogo()
        
        buttonAuthenticate.setCornerRadius()
    }
    
    /// Called when the iOS interface environment changes.
    /// - parameter previousTraitCollection: The `UITraitCollection` object before the interface environment changed.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            setTraitAppearance()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AssertionInfoViewController, let assertion = sender as? PublicKeyCredential<AuthenticatorAssertionResponse> {
            viewController.assertion = assertion
            viewController.isModalInPresentation = true
        }
    }
    
    @IBAction func unwindToAssertionView(sender: UIStoryboardSegue) {
        if let viewController = sender.source as? AssertionInfoViewController {
            imageView.tintColor = viewController.success ? UIColor.systemGreen : UIColor.systemRed
            
            animateLogo {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    self.setTraitAppearance()
                }
            }
        }
    }
}
