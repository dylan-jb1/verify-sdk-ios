//
//  FidoService.swift
//

import Foundation
import FIDO2
import os.log


public class FidoService {
    /// Returns the shared defaults object.
    internal static let shared = FidoService()
    
    // MARK: Networking functions

    func fetchAttestationOptions(_ relyingPartyURL: String, accessToken: String, params: [String: Any]? = [:], completion: @escaping (Result<PublicKeyCredentialCreationOptions, NetworkError>) -> Void) {
        guard let url = URL(string: relyingPartyURL) else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        var parameters = ["attestation":"direct"] as [String: Any]
        
        
        // Append the additional params to the JSON request.
        if let params = params {
            parameters.merge(params) { (current, _) in current }
        }
        
        guard let bodyData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            Logger.networking.debug("Unable to create request payload for WebAuthn.Attestation.options.")
            completion(.failure(NetworkError.invalidData))
            return
        }
            
        Logger.networking.info("HTTP request\n\(String(data: bodyData, encoding: .utf8)!, privacy: .public)")
        request.httpBody = bodyData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let _ = response, error == nil else {
                completion(.failure(.general(message: error!.localizedDescription)))
                return
            }
            
            Logger.networking.info("HTTP response\n\(String(data: data, encoding: .utf8)!, privacy: .public)")
            
            do {
                guard let value = try? JSONDecoder().decode(PublicKeyCredentialCreationOptions.self, from: data) else {
                    Logger.networking.debug("Unable to parse PublicKeyCredentialCreationOptions.")
                    completion(.failure(.general(message: "Unable to parse PublicKeyCredentialCreationOptions.")
                    ))
                    return
                }
                completion(.success(value))
            }
        }.resume()
    }
}
