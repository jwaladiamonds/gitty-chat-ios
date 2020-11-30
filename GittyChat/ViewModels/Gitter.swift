//
//  Data.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI

let defaults = UserDefaults.standard

class Gitter: ObservableObject {
    
    let client = Client()
    var auth: OAuth
    
    @Published var credential: GCredential?
    @Published var loggedIn = false
    
    @Published var user: GUser?
    @Published var rooms: [GRoom]?
    @Published var groups: [GGroup]?
    @Published var selectedRoom: GRoom?
    
    init() {
        self.auth = OAuth(client: client)
    }
    
    func loadInitialData() {
        self.getUser()
        self.getRooms()
        self.getGroups()
    }
    
    func getUser() {
        client.fetchJSON(url: "https://api.gitter.im/v1/user/me", credential: credential) { data in
            self.user = data
        }
    }
    
    func getRooms() {
        auth.client.fetchJSON(url: "https://api.gitter.im/v1/rooms", credential: credential) { data in
            self.rooms = data
        }
    }
    
    func getGroups() {
        auth.client.fetchJSON(url: "https://api.gitter.im/v1/groups", credential: credential) { data in
            self.groups = data
        }
    }
    
    func login(credential: GCredential) {
        self.loggedIn = true
        self.credential = credential
        self.auth.save(credential: credential)
    }
    
    func logout() {
        self.loggedIn = false
        self.credential = nil
        defaults.removeObject(forKey: "GitterCredential")
    }
    
}
