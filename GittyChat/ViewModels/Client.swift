//
//  Network.swift
//  GittyChat
//
//  Created by Nikhil John on 28/11/20.
//

import Foundation

extension Client {
    
    func fetchCredential(code: String?, debug: Bool = false,_ completion: @escaping (GCredential) -> Void) {
        if let code = code {
            let requestBody: [String: String] = [
                "client_id": self.key,
                "client_secret": self.secret,
                "code": code,
                "redirect_uri": self.redirect,
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
            self.fetchData(request: request, debug: debug) { data in
                completion(data)
            }
        }
    }
    
    func fetchJSON<Content: Codable>(url: String, credential: GCredential?,_ completion: @escaping (Content) -> Void) {
        if let credential = credential {
            let url = URL(string: url)!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue(credential.token_type + " " + credential.access_token, forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ss.SSS'Z'"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(formatter)
            self.fetchData(request: request, decoder: decoder){ data in
                completion(data)
            }
        }
    }
    
    private func fetchData<Content: Codable>(
        request: URLRequest,
        acceptType: String? = "application/json",
        debug: Bool = false,
        decoder: JSONDecoder = JSONDecoder(),
        _ completion: @escaping (Content) -> Void) {
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
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            if let acceptType = acceptType {
                guard let mimeType = httpResponse.mimeType,
                      mimeType == acceptType else {
                    print("Invalid MIME Type: \(httpResponse.mimeType ?? "None").")
                    return
                }
            }
            if debug {
                if let string = String(data: data, encoding: .utf8) {
                    print(string)
                }
            }
            do {
                let decodedResponse = try decoder.decode(Content.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedResponse)
                }
                return
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
