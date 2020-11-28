//
//  GGroup.swift
//  GittyChat
//
//  Created by Nikhil John on 28/11/20.
//

import Foundation

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


struct GGroup: Codable {
    var id: String
    var name: String
    var uri: String
    var homeUri: String?
    var backedBy: GBacking
    var avatarUrl: String
}
