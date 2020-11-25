//
//  RoomView.swift
//  GittyChat
//
//  Created by Nikhil John on 25/11/20.
//

import SwiftUI

struct RoomView: View {
    var room: GRoom
    var body: some View {
        VStack {
            if let url = room.avatarUrl {
                ImageView(url: url)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            }
            Text(room.name)
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
                Text(room.name)
            }
            .padding(.vertical, 10)
        }
    }
}

