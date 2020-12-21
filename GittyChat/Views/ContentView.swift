//
//  ContentView.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI
import SafariServices

struct ContentView: View {
    @EnvironmentObject var gitter: Gitter
    var body: some View {
        ZStack {
            MainView()
            WelcomeView()
                .offset(x: !gitter.loggedIn ? 0 : -UIScreen.main.bounds.width)
                .transition(.move(edge: .leading))
                .animation(.easeInOut(duration: 0.2))
        }
        .accentColor(.ruby)
    }
}

struct SafariView: UIViewControllerRepresentable {
    var url: URL
        
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let safariView = SFSafariViewController(url: url)
        return safariView
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
}
