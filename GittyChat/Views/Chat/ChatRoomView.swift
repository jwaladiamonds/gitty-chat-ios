//
//  ChatRoomView.swift
//  GittyChat
//
//  Created by Nikhil John on 01/12/20.
//

import SwiftUI

struct ChatRoomView: View {
    @EnvironmentObject var gitter: Gitter
    var room: GRoom
    @State private var chatMessage: String = ""
    @State private var messages = [String]()
    var body: some View {
        VStack {
            Text(room.name)
                .font(.system(size: 30, weight: .black, design: .rounded))
            ChatLogView(messages: $messages)
            TextField("Enter message", text: $chatMessage)
        }
    }
}


//struct ChatView: View {
//    var room: GRoom?
//    @State private var chatMessage: String = ""
//    @State private var messages: [String] = [String]()
//    var body: some View {
//        GeometryReader { geo in
//            ZStack {
//                Color(UIColor.systemBackground)
//                    .edgesIgnoringSafeArea(.all)
//                VStack {
//                    Text(room?.topic ?? "Unknown topic")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    MessageLogView(messages: messages)
//                    TextField("Enter message", text: $chatMessage)
//                    .padding(12)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.ruby))
//                }
//                .padding()
//            }
//            .offset(x: room == nil ? geo.size.width : 0)
//        }
//        .frame(maxHeight: .infinity)
//    }
//}
//

struct ChatLogView: View {
    @Binding var messages: [String]
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
