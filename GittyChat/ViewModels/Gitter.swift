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
    @ObservedObject var auth: OAuth
    
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
        client.fetchJSON(url: "https://api.gitter.im/v1/user/me", credential: auth.credential) { data in
            self.user = data
        }
    }
    
    func getRooms() {
        auth.client.fetchJSON(url: "https://api.gitter.im/v1/rooms", credential: auth.credential) { data in
            self.rooms = data
        }
    }
    
    func getGroups() {
        auth.client.fetchJSON(url: "https://api.gitter.im/v1/groups", credential: auth.credential) { data in
            self.groups = data
        }
    }
    
    
}
