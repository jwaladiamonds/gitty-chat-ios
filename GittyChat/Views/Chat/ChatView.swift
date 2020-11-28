//
//  ChatView.swift
//  GittyChat
//
//  Created by Nikhil John on 27/11/20.
//

import SwiftUI

struct ChatView: View {
    var room: GRoom?
    @State private var chatMessage: String = ""
    @State private var messages: [String] = [String]()
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text(room?.topic ?? "Unknown topic")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    MessageLogView(messages: messages)
                    TextField("Enter message", text: $chatMessage)
                    .padding(12)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.ruby))
                }
                .padding()
            }
            .offset(x: room == nil ? geo.size.width : 0)
        }
        .frame(maxHeight: .infinity)
    }
}

struct MessageLogView: View {
    var messages: [String]
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(messages.indices, id: \.self) { index in
                    Text(messages[index]).id(index)
                }
            }
        }
    }
}
