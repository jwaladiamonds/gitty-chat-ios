//
//  Auth.swift
//  GittyChat
//
//  Created by Nikhil John on 25/11/20.
//

import SwiftUI

class OAuth: ObservableObject {
    
    @Published var client: Client
    @Published var credential: GCredential?
    @Published var loggedIn = false
    
    init(client: Client) {
        self.client = client
    }
    
    private var authURL:String {
        return "https://gitter.im/login/oauth/authorize?client_id=\(self.client.key)&response_type=code&redirect_uri=\(self.client.redirect)"
    }
    
    func openAuthURL() {
        if let url = URL(string: self.authURL) {
            UIApplication.shared.open(url)
        }
    }
    
    func authorize(code: String?) {
        client.fetchCredential(code: code, debug: true) { credential in
            self.login(credential: credential)
        }
    }
    
    func login(credential: GCredential) {
        print("Logging in...")
        self.loggedIn = true
        self.credential = credential
        self.save()
    }
    
    func logout() {
        self.loggedIn = false
        self.credential = nil
        defaults.removeObject(forKey: "GitterCredential")
    }
    
    func load() {
        if let savedCredential = UserDefaults.standard.object(forKey: "GitterCredential") as? Data {
            let decoder = JSONDecoder()
            if let credential = try? decoder.decode(GCredential.self, from: savedCredential) {
                self.login(credential: credential)
            }
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(self.credential) {
            defaults.set(encoded, forKey: "GitterCredential")
            return
        }
    }
}
