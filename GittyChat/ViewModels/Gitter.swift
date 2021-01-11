//
//  Data.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI
import OAuthSwift
import Combine

let defaults = UserDefaults.standard

class Gitter: ObservableObject {

    var oauth: OAuth2Swift?
    
    @Published var loggedIn = false
    
    var subscriptions = Set<AnyCancellable>()
    
    var credential: OAuthSwiftCredential? {
        didSet {
            if let credential = credential, !credential.isTokenExpired() {
                self.loggedIn = true
            }
        }
    }
    
    @Published var user: GUser?
    @Published var rooms: [GRoom]?
    @Published var groups: [GGroup]?
    @Published var selectedRoom: GRoom?

    let gitterDecoder = JSONDecoder()
    
    init() {
        self.oauth = getGitterOAuth(
            key: ClientOAuthData.key,
            secret: ClientOAuthData.secret,
            redirect: ClientOAuthData.redirect
        )
        gitterDecoder.upgradeDecoderFormat()
    }
    
    func getGitterOAuth(key: String, secret: String, redirect: String) -> OAuth2Swift {
        let oauthswift = OAuth2Swift(
            consumerKey:    key,
            consumerSecret: secret,
            authorizeUrl:   "https://gitter.im/login/oauth/authorize",
            accessTokenUrl: "https://gitter.im/login/oauth/token",
            responseType:   "code"
        )
        return oauthswift
    }
    
    func loadInitialData() {
        self.getUser()
        self.getRooms()
        self.getGroups()
    }
    
    enum AppError: Error {
        case impossible
    }
    
    func getUser() {
        oauth?.client.get(URL(string: "https://api.gitter.im/v1/user/me")!) { result in
            switch result {
            case .success(let response):
                Just(response.data)
                    .decode(type: GUser.self, decoder: self.gitterDecoder)
                .sink(receiveCompletion: { print ("Completion of User: \($0)")},
                      receiveValue: { self.user = $0 })
                    .store(in: &self.subscriptions)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRooms() {
        oauth?.client.get(URL(string: "https://api.gitter.im/v1/rooms")!) { result in
            switch result {
            case .success(let response):
                Just(response.data)
                    .decode(type: [GRoom].self, decoder: self.gitterDecoder)
                    .sink(receiveCompletion: { print ("Completion of Rooms: \($0)")},
                          receiveValue: { self.rooms = $0 })
                    .store(in: &self.subscriptions)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getGroups() {
        oauth?.client.get(URL(string: "https://api.gitter.im/v1/groups")!) { result in
            switch result {
            case .success(let response):
                Just(response.data)
                    .decode(type: [GGroup].self, decoder: self.gitterDecoder)
                    .sink(receiveCompletion: { print ("Completion of Group: \($0)")},
                          receiveValue: { self.groups = $0 })
                    .store(in: &self.subscriptions)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func login() {
        let state = generateState(withLength: 20)
        oauth?.authorize(
        withCallbackURL: URL(string: ClientOAuthData.redirect)!, scope: "flow", state: state) { result in
            switch result {
            case .success(let (credential, _, _)):
                self.credential = credential
                print(credential.oauthToken)
                self.loadInitialData()
            case .failure(let error):
                print(error.localizedDescription, terminator: "")
            }
        }
    }
    
    func logout() {
        self.loggedIn = false
        self.credential = nil
        defaults.removeObject(forKey: "GitterCredential")
    }
    
}


extension JSONDecoder {
    func upgradeDecoderFormat() {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ss.SSS'Z'"
        self.dateDecodingStrategy = .formatted(formatter)
    }
}
