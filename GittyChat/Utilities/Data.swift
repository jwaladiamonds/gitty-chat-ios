//
//  Data.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI

struct Profile {
    var id: String?
    var username: String?
    var displayName: String?
    var url: String?
    var avatarUrl: String?
    var staff: Bool?
    var providers: [String]?
    var version: Int?
    var gitterVersion: String?
}

struct Credential: Codable {
    var access_token: String
    var expires_in: String?
    var token_type: String
}

struct Client {
    var id: String?
    var secret: String?
    var redirectURI: String?
    var host = "redirect"
    
    init() {
        if let data = self.getData() {
            self.id = data["OAuthClientId"] as? String
            self.secret = data["OAuthClientSecret"] as? String
            self.redirectURI = data["OAuthCallback"] as? String
        }
    }
    
    private func getData() -> [String: Any]? {
        if let path = Bundle.main.path(forResource: "Gitter", ofType: "plist"),
           let xml = FileManager.default.contents(atPath: path) {
            return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [String: Any]
        }
        return nil
    }
}

class Gitter: ObservableObject {
    var client = Client()
    var credentials: Credential?
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
                        self.credentials = decodedResponse
                    }
                    return
                }
                print("Unable to decode response")
            }.resume()
        }
    }
}


