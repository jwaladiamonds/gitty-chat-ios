//
//  Auth.swift
//  GittyChat
//
//  Created by Nikhil John on 25/11/20.
//

import SwiftUI

class OAuth {
    
    var client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func openAuthURL() {
        let authURL = "https://gitter.im/login/oauth/authorize"
        let parameters = "?client_id=\(self.client.key)" +
            "&response_type=code&" +
            "redirect_uri=\(self.client.redirect)"
        if let url = URL(string: authURL + parameters) {
            UIApplication.shared.open(url)
        }
    }
    
    func authorize(code: String?,_ completion: @escaping (GCredential) -> Void) {
        client.fetchCredential(code: code, debug: true) { credential in
            completion(credential)
        }
    }
    
    func load(_ completion: @escaping (GCredential) -> Void) {
        if let savedCredential = UserDefaults.standard.object(forKey: "GitterCredential") as? Data {
            let decoder = JSONDecoder()
            if let credential = try? decoder.decode(GCredential.self, from: savedCredential) {
                completion(credential)
            }
        }
    }
    
    func save(credential: GCredential) {
        if let encoded = try? JSONEncoder().encode(credential) {
            defaults.set(encoded, forKey: "GitterCredential")
            return
        }
    }
}
