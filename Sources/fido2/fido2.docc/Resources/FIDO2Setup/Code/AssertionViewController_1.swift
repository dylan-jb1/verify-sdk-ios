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
    
    
}
