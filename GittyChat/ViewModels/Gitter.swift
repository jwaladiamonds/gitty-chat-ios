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
    
    @AppStorage("loggedIn") var loggedIn = false
    
    @Published var credential: GCredential?
    @Published var user: GUser?
    @Published var rooms: [GRoom]?
    @Published var groups: [GGroup]?
    @Published var selectedRoom: GRoom?
    
    init() {
        self.auth = OAuth(client: client)
        if loggedIn {
            self.auth.load { credential in
                self.login(credential: credential)
            }
        }
    }
    
    func loadInitialData() {
        self.getUser()
        self.getRooms()
        self.getGroups()
    }
    
    func getUser() {
        auth.client.fetchJSON(url: "https://api.gitter.im/v1/user/me", credential: credential) { data in
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
        self.loadInitialData()
    }
    
    func logout() {
        self.loggedIn = false
        self.credential = nil
        defaults.removeObject(forKey: "GitterCredential")
    }
    
}
