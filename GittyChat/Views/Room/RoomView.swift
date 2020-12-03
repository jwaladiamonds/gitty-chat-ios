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
        EmptyView()
            .onAppear{
                gitter.selectedRoom = room
            }
//        VStack {
//            if let url = room.avatarUrl {
//                ImageView(url: url)
//                    .clipShape(Circle())
//                    .frame(width: 100, height: 100)
//            }
//            Text(room.name)
//        }
    }
}

struct RoomItem: View {
    var room: GRoom
//    @Binding var tabBar: UITabBar!
    var body: some View {
        NavigationLink(destination:
            RoomView(room: room)
//                .onAppear {
//                    withAnimation(.spring()){
//                        self.tabBar.isHidden = true
//                        self.setTabBarVisible(hide: true, tabBar: self.tabBar)
//                    }
//                }
//                .onDisappear {
//                    withAnimation(.spring()){
//                        self.tabBar.isHidden = false
//                        self.setTabBarVisible(hide: false, tabBar: self.tabBar)
//                    }
//                }
            ) {
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
    
//    func setTabBarVisible(hide: Bool, tabBar: UITabBar?) {
//
//        // get a frame calculation ready
//        let frame = tabBar?.frame
//        let height = frame?.size.height
//        let offsetY = (hide ? height: -height!)
//
//        // zero duration means no animation
//        let duration: TimeInterval = 0.3
//
//        //  animate the tabBar
//        if frame != nil {
//            UIView.animate(withDuration: duration) {
//                tabBar?.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
//                return
//            }
//        }
//    }
}

