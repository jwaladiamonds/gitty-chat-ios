//
//  GittyChatApp.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI

@main
struct GittyChatApp: App {
    @StateObject var gitter = Gitter()
    @StateObject var uiModel = UIModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gitter)
                .environmentObject(uiModel)
                .onOpenURL { url in
                    if let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
                       let params = components.queryItems {
                        gitter.showLoginView = false
                        gitter.auth.authorize(code: params.first(where: { $0.name == "code" })?.value) { credential in
                            gitter.login(credential: credential)
                        }
                    }
                }
        }
    }
}
