//
//  GRoom.swift
//  GittyChat
//
//  Created by Nikhil John on 28/11/20.
//

import Foundation

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
