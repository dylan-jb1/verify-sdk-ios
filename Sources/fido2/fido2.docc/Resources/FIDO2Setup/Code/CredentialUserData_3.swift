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
/// The assertion response returned after a `WebAuthnAPIClient.Assertion.get()` operation.
public protocol AssertionResponse: Decodable {
    /// The unique identifier of the user.
    var userId: String {
        get
    }
    
    /// The relying party ID this enrollment belongs to.
    var rpId: String {
        get
    }
    
    /// The friendly name of the registration record.
    var nickname: String {
        get
    }
    
    /// A name-value pair of user related credential attributes.
    var attributes: [CredentialUserAttribute: Any] {
        get
    }
}

/// The assertion response returned after a `WebAuthnAPIClient.Assertion.get()` operation.
public protocol AttestationResponse {
    /// The friendly name of the registration record.
    var nickname: String {
        get
    }
    
    var attestation: PublicKeyCredential<AuthenticatorAttestationResponse> {
        get
    }
}

/// The asstestation response is a placeholder protocol to support IBM Verify on-premise FIDO server implementations
public struct ISVAAsstestationResponse: AttestationResponse, Codable {
    public let attestation: PublicKeyCredential<AuthenticatorAttestationResponse>
    public let nickname: String
    
    public init(_ nickname: String, attestation: PublicKeyCredential<AuthenticatorAttestationResponse>) {
        self.nickname = nickname
        self.attestation = attestation
    }
    
    /// Encodes this value into the given encoder.
    /// - parameters to: The encoder to write data to.
    /// - throws: This function throws an error if any values are invalid for the given encoder’s format.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(nickname, forKey: .nickname)
        try attestation.encode(to: encoder)
    }
}

/// The asstestation response is a placeholder protocol to support IBM Verify cloud FIDO server implementations
public struct ISVAsstestationResponse: AttestationResponse, Codable {
    public let attestation: PublicKeyCredential<AuthenticatorAttestationResponse>
    public let nickname: String
    public let enabled: Bool
    
    public init(_ nickname: String, enabled: Bool = true, attestation: PublicKeyCredential<AuthenticatorAttestationResponse>) {
        self.nickname = nickname
        self.enabled = enabled
        self.attestation = attestation
    }
    
    /// Encodes this value into the given encoder.
    /// - parameters to: The encoder to write data to.
    /// - throws: This function throws an error if any values are invalid for the given encoder’s format.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(nickname, forKey: .nickname)
        try container.encode(enabled, forKey: .enabled)
        try attestation.encode(to: encoder)
    }
}

// MARK: Structures
