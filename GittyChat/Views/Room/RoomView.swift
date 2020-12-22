//
//  RoomView.swift
//  GittyChat
//
//  Created by Nikhil John on 25/11/20.
//

import SwiftUI

struct RoomView: View {
    var room: GRoom
    @EnvironmentObject var gitter: Gitter
    var body: some View {
        ChatView(room: room)
            .onAppear{
                gitter.selectedRoom = room
            }
    }
}

struct RoomItem: View {
    var room: GRoom
    var body: some View {
        NavigationLink(destination: RoomView(room: room)) {
            HStack {
                Group {
                    if let url = room.avatarUrl {
                        ImageView(url: url)
                    } else {
                        Image(systemName: "person.fill")
                    }
                }
                .clipShape(Circle())
                .frame(width: 32, height: 32)
                .padding(.trailing, 4)
                HStack {
                    if room.favourite != nil {
                        Image(systemName: "star.fill").opacity(0.5)
                    }
                    Text(room.name)
                }
            }
            .padding(.vertical, 10)
        }
        .contextMenu {
            if room.favourite == nil {
                Button(action: {
                    // No action
                }) {
                    Text("Favorite")
                    Image(systemName: "star.fill")
                }
            } else {
                Button(action: {
                    // No action
                }) {
                    Text("Unfavorite")
                    Image(systemName: "star")
                }
            }
            Button(action: {
                // No action
            }) {
                Text("Leave room")
                Image(systemName: "clear")
            }
        }
    }
}
