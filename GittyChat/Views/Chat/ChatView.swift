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

//struct ChatViewOld: View {
//    var room: GRoom
//    @State private var text = ""
//    @State private var messageCount: Int = 60
//    @EnvironmentObject var gitter: Gitter
//    var body: some View {
//        ScrollViewReader { scrollView in
//            VStack(spacing: 0) {
//                ScrollView(.vertical, showsIndicators: false) {
//                    LazyVStack(alignment: .leading) {
//                        ForEach(0 ..< messageCount) { item in
//                            Text("Hello \(item)").id(item)
//                        }
//                    }
//                    .padding(.horizontal)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .onAppear{
//                        scrollView.scrollTo(messageCount-1, anchor: .bottom)
//                    }
//                }
//
//                MessageField(text: $text) {
//                    print("Sending following text:")
//                    print(self.text)
//                    withAnimation {
//                        scrollView.scrollTo(messageCount-1, anchor: .bottom)
//                    }
//                }
//            }
//        }
//    }
//}
