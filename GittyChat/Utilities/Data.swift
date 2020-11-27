//
//  Data.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI

let defaults = UserDefaults.standard

class Gitter: ObservableObject {
    
    let client = OAuth()
    
    @Published var user: GUser?
    @Published var rooms: [GRoom]?
    @Published var groups: [GGroup]?
    @Published var credential: GCredential?
    @Published var loggedIn = false
    
    func loadInitialData() {
        self.getUser()
        self.getRooms()
        self.getGroups()
    }
    
    func getUser() {
        fetch(url: "https://api.gitter.im/v1/user/me") { data in
            self.user = data
        }
    }
    
    func getRooms() {
        fetch(url: "https://api.gitter.im/v1/rooms") { data in
            self.rooms = data
        }
    }
    
    func getGroups() {
        fetch(url: "https://api.gitter.im/v1/groups") { data in
            self.groups = data
        }
    }
}


extension Gitter {
    
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
                   let data = data {
//                   let data = data, let string = String(data: data, encoding: .utf8) {
//                    print(string)
                    let formatter = DateFormatter()
                    formatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ss.SSS'Z'"
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    do {
                        let decodedResponse = try decoder.decode(Content.self, from: data)
                        DispatchQueue.main.async {
                            completion(decodedResponse)
                        }
                        return
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
    
}
