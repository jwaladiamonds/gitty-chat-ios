//
//  GMessage.swift
//  GittyChat
//
//  Created by Nikhil John on 28/12/20.
//

import SwiftUI

protocol MessageModelProtocol: Identifiable {
    associatedtype User: UserModelProtocol
    var id: String { get }
    var fromUser: User { get }
    var text: String { get }
    var sent: Date { get }
}

struct GMessage: Identifiable, MessageModelProtocol {
    var id: String
    var fromUser: GUser
    var text: String
    var sent: Date
}
