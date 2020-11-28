//
//  GCredential.swift
//  GittyChat
//
//  Created by Nikhil John on 28/11/20.
//

import Foundation

struct GCredential: Codable {
    var access_token: String
    var expires_in: String?
    var token_type: String
}
