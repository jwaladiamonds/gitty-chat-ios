//
//  Models.swift
//  GittyChat
//
//  Created by Nikhil John on 21/11/20.
//

import Foundation

struct User {
    var id: String
    var username: String
    var displayName: String
    var url: String
    var avatarUrlSmall: String?
    var avatarUrlMedium: String?
    var avatarUrl: String?
    var role: String?
    var staff: Bool?
    var providers: [String]?
    var v: Int?
    var gV: String?
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

struct Room {
    enum type {
        case org
        case repo
        case oneToOne
        case orgChannel
        case repoChannel
        case userChannel
    }
    
    var id: String
    var name: String
    var topic: String
    var uri: String?
    var oneToOne: Bool
    var user: User?
    var users: [User]?
    var userCount: Int?
    var unreadItems: Int
    var mentions: Int
    var lastAccessTime: Date?
    var favourite: String?
    var lurk: Bool
    var url: String
    var githubType: type
    var tags: String?
    var v: Int?
}
