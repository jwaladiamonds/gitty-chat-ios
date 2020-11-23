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
    @Published var user: User?
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
        self.getUser()
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
    
    func fetch<Content: Codable>(url: String,_ completion: @escaping (Content) -> Void) {
        if let credential = self.credential {
            let url = URL(string: url)!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue(credential.authorization, forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print(response.debugDescription)
                    return
                }
                
                if let mimeType = httpResponse.mimeType, mimeType == "application/json",
                   let data = data { //}, let string = String(data: data, encoding: .utf8) {
                    if let decodedResponse = try? JSONDecoder().decode(Content.self, from: data) {
                        DispatchQueue.main.async {
                            completion(decodedResponse)
                        }
                        return
                    }
                }
            }.resume()
        }
    }
    
    func getUser() {
        fetch(url: "https://api.gitter.im/v1/user/me") { data in
            self.user = data
        }
    }
}


