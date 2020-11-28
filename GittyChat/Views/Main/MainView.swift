//
//  MainView.swift
//  GittyChat
//
//  Created by Nikhil John on 21/11/20.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }.tag(1)
            PeopleView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("People")
                }.tag(2)
            CommunitiesView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Communities")
                }.tag(3)
        }
        .font(.headline)
        .overlay(ChatView())
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
