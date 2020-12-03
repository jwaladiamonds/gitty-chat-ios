//
//  MainView.swift
//  GittyChat
//
//  Created by Nikhil John on 21/11/20.
//

import SwiftUI

enum Tab: String {
    case home = "Home"
    case chat = "Chat"
}

struct MainView: View {
    @State var selectedTab = 0
    @State var selectedInnerTab: Tab = .home
    var body: some View {
        TabView(selection: $selectedTab) {
            ProfileView().tag(1)
            NavigationView {
                TabView(selection: $selectedInnerTab) {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text(Tab.home.rawValue)
                        }.tag(Tab.home)
                    ChatView()
                        .tabItem {
                            Image(systemName: "bubble.left.and.bubble.right.fill")
                            Text(Tab.chat.rawValue)
                        }.tag(Tab.chat)
                }
                .font(.headline)
//                .navigationBarTitle(selectedInnerTab.rawValue)
            }.tag(0)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
