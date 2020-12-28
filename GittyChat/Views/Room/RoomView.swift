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
            .onTapGesture {
                UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
            }
            .onAppear{
                gitter.selectedRoom = room
            }
    }
}
