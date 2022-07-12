//
// Copyright contributors to the IBM Security Verify FIDO2 Sample App for iOS project
//

import Foundation
import os.log
import FIDO2

// MARK: Enums

/// The attributes that can be returned by the FIDO server for a user.
public enum CredentialUserAttribute: String {
    /// The metadata icon of the authenticator
    case icon
    
    /// The unique identifier of the user.
    case userId
    
    /// The name of the user.
    case username
    
    /// The email of the user.
    case email
    
    /// The friendly name of the registration record
    case nickname
    
    /// The metadata description of the authenticator
    case description
    
    /// The AAGuid of the authenticator used ,
    case aaguid
    
    /// The relying party ID this enrollment belongs to.
    case rpId
    
    /// The format of attestation that was performed ,
    case attestationFormat
    
    /// The type of attestation that was performed ,
    case attestationType
    
    /// The attestation trust path of the authenticator.
    case attestationTrustPath
    
    /// The counter of this authenticator.
    case counter
    
    /// The public key issued by the authenticator.
    case credentialPublicKey
    
    ///  The credential ID of the authenticator
    case credentialId
    
    ///  The authenticator extension for txAuthSimple
    case txAuthSimple
}

// MARK: Protocols

// MARK: Structures
