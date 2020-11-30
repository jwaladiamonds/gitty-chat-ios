//
//  ContentView.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var gitter: Gitter
    var body: some View {
        ZStack {
            MainView()
            if !gitter.loggedIn {
                WelcomeView()
                    .offset(x: gitter.credential == nil ? 0 : -UIScreen.main.bounds.width)
                    .transition(.move(edge: .leading))
                    .animation(.easeInOut(duration: 0.2))
            }
        }.onAppear{ print(gitter.loggedIn) }
        .accentColor(.ruby)
    }
}
