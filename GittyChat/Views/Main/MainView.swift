//
//  MainView.swift
//  GittyChat
//
//  Created by Nikhil John on 21/11/20.
//

import SwiftUI

enum Tab: String {
    case home = "Home"
    case profile = "Profile"
}

struct MainView: View {
    @State var selectedInnerTab: Tab = .home
    var body: some View {
        NavigationView {
            TabView(selection: $selectedInnerTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text(Tab.home.rawValue)
                    }.tag(Tab.home)
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text(Tab.profile.rawValue)
                    }.tag(Tab.profile)
            }
            .font(.headline)
            .navigationBarTitle(selectedInnerTab.rawValue)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
