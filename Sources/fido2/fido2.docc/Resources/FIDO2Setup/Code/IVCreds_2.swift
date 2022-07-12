//
// Copyright contributors to the IBM Security Verify FIDO2 Sample App for iOS project
//

import Foundation
import os.log

// MARK: Structures

/// Represents the ivcreds from the Web Reverse Proxy.
public struct IVCreds {
    /// Represents the username - extracted from AZN_CRED_PRINCIPAL_NAME attribute
    public var username: String
    
    /// Represents all other attributes of the cred
    public var attributes: [String: Any]?
    
    enum IVCredsError: Error {
        case notAuthenticated
    }
    
    // Creates a new `IVCreds` instance
    public init(jsonData: Data) throws {
        self.username = "unauthenticated"
        let json = try? JSONSerialization.jsonObject(with: jsonData, options: [])
        if let ivcreds = json as? [String:Any] {
            if ivcreds["AZN_CRED_PRINCIPAL_NAME"] == nil || ivcreds["AZN_CRED_PRINCIPAL_NAME"] as! String == "unauthenticated"  {
                throw IVCredsError.notAuthenticated
            }
            self.username = ivcreds["AZN_CRED_PRINCIPAL_NAME"] as! String
            self.attributes = ivcreds
        }
    }
}
