//
//  ChatView.swift
//  GittyChat
//
//  Created by Nikhil John on 27/11/20.
//

import SwiftUI

struct ChatView: View {
    var room: GRoom
    @State private var text = ""
    @EnvironmentObject var gitter: Gitter
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    VStack(alignment: .leading) {
                        ForEach(0 ..< 60) { item in
                            Text("Hello \(item+1)")
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            ChatField(text: $text, placeholder: "Message") {
                print("Sending following text:")
                print(self.text)
            }
            .background(Color(.systemBackground).edgesIgnoringSafeArea(.bottom))
            .overlay(Divider(), alignment: .top)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitle(room.name, displayMode: .inline)
        .onTapGesture {
            UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
        }
    }
}

struct TestRoom: View {

    @State var text = ""
    @State var height: CGFloat = 0

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(0 ..< 60) { item in
                        Text("Hello \(item+1)")
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            ChatField(text: $text, height: height) {
                print("Sending following text:")
                print(self.text)
            }
        }
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        TestRoom(height: 38)
    }
}
