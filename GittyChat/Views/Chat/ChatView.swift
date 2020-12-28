//
//  ChatView.swift
//  GittyChat
//
//  Created by Nikhil John on 27/11/20.
//

import SwiftUI

struct ChatView: View {
    @State var message = ""
    @State var messages = [GMessage]()
    var room: GRoom
    var body: some View {
        VStack {
            MessageScroll(messages: messages) { message in
                ChatBubble(message: message)
            }
            MessageField(text: $message) {
                //  Sent message here
            }
            .background(Color(.systemBackground).edgesIgnoringSafeArea(.bottom))
            .overlay(Divider(), alignment: .top)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitle(room.name, displayMode: .inline)
    }
}
