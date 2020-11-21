//
//  Data.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI

let defaults = UserDefaults.standard

class Gitter: ObservableObject {
    @Published var client = Client()
    @Published var credential: Credential?
    @Published var loggedIn = false
    
    var authURL:String {
        return "https://gitter.im/login/oauth/authorize?client_id=\(self.client.id!)&response_type=code&redirect_uri=\(self.client.redirectURI!)"
    }
    
    func openAuthURL() {
        if let url = URL(string: self.authURL) {
            UIApplication.shared.open(url)
        }
    }
    
    func auth(code: String?) {
        if let code = code {
            let requestBody: [String: String] = [
                "client_id": self.client.id!,
                "client_secret": self.client.secret!,
                "code": code,
                "redirect_uri": self.client.redirectURI!,
                "grant_type": "authorization_code"
            ]
            guard let encoded = try? JSONEncoder().encode(requestBody) else {
                print("Failed to encode order")
                return
            }
            let url = URL(string: "https://gitter.im/login/oauth/token")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = encoded
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let data = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                    return
                }
                if let decodedResponse = try? JSONDecoder().decode(Credential.self, from: data) {
                    DispatchQueue.main.async {
                        self.login(credential: decodedResponse)
                    }
                    return
                }
                print("Unable to decode response")
            }.resume()
        }
    }
    
    func login(credential: Credential) {
        self.loggedIn = true
        self.credential = credential
        self.save()
    }
    
    func logout() {
        self.loggedIn = false
        self.credential = nil
        defaults.removeObject(forKey: "GitterCredential")
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.credential) {
            defaults.set(encoded, forKey: "GitterCredential")
            return
        }
    }
}


