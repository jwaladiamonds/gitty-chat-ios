//
//  GUser.swift
//  GittyChat
//
//  Created by Nikhil John on 28/11/20.
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
