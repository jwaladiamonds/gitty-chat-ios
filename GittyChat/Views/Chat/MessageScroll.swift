//
//  MessageScroll.swift
//  GittyChat
//
//  Created by Nikhil John on 28/12/20.
//

import SwiftUI

struct MessageScroll<Content: View, Message: MessageModelProtocol>: View {
    
    var messages: [Message]
    var content: (Message) -> Content
    let padding: CGFloat
    
    init(messages: [Message], padding: CGFloat = 10, @ViewBuilder _ content: @escaping (Message) -> Content) {
        self.content = content
        self.messages = messages
        self.padding = padding
    }
    
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(messages) { message in
                        content(message).id(message.id)
                    }
                }
                .padding(.horizontal, padding)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}
