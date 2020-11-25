//
//  MainView.swift
//  GittyChat
//
//  Created by Nikhil John on 21/11/20.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
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
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
