//
//  GUser.swift
//  GittyChat
//
//  Created by Nikhil John on 28/11/20.
//

import Foundation

protocol UserModelProtocol: Identifiable {
    var id: String { get }
    var username: String { get }
}

struct GUser: Codable, UserModelProtocol {
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
