//
//  Models.swift
//  GittyChat
//
//  Created by Nikhil John on 21/11/20.
//

import Foundation

struct GUser: Codable {
    var id: String
    var username: String
    var displayName: String
    var url: String
    var avatarUrl: String?
    var avatarUrlSmall: String?
    var avatarUrlMedium: String?
    var role: String?
    var staff: Bool?
    var providers: [String]?
    var v: Int?
    var gv: String?
}

struct GCredential: Codable {
    var access_token: String
    var expires_in: String?
    var token_type: String
    var authorization: String {
        return token_type + " " + access_token
    }
}

struct GClient {
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

struct GBacking: Codable {
    enum ChannelType: String, Codable {
        case oneToOne = "ONE_TO_ONE"
        case githubRepo = "GH_REPO"
        case githubOrg = "GH_ORG"
        case githubUser = "GH_USER"
        case githubGroup = "GH_GROUP"
        case gitlabRepo = "GL_REPO"
        case gitlabOrg = "GL_ORG"
        case gitlabUser = "GL_USER"
        case gitlabGroup = "GL_GROUP"
    }
    
    var type: ChannelType?
    var linkPath: String
}

struct GRoom: Codable {
    enum GithubType: String, Codable {
        case org = "ORG"
        case repo = "REPO"
        case oneToOne = "ONETOONE"
        case orgChannel = "ORG_CHANNEL"
        case repoChannel = "REPO_CHANNEL"
        case userChannel = "USER_CHANNEL"
    }
    
    struct Permission: Codable {
        var admin: Bool?
    }
    
    var id: String
    var name: String
    var topic: String
    var avatarUrl: String?
    var uri: String?
    var oneToOne: Bool
    var user: GUser?
    var users: [GUser]?
    var userCount: Int?
    var unreadItems: Int
    var mentions: Int
    var lastAccessTime: Date?
    var favourite: Int?
    var lurk: Bool
    var url: String
    var githubType: GithubType
    var security: String?
    var noindex: Bool?
    var tags: [String]?
    var permissions: Permission?
    var roomMember: Bool?
    var groupId: String?
    var `public`: Bool?
    var v: Int?
}


struct GGroup: Codable {
    var id: String
    var name: String
    var uri: String
    var homeUri: String?
    var backedBy: GBacking
    var avatarUrl: String
}
