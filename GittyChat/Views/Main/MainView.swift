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
    @State var selection: Tab = .home
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                ProfileView().tag(Tab.profile)
                HomeView().tag(Tab.home)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
