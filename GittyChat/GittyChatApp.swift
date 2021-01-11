//
//  GittyChatApp.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI
import OAuthSwift

@main
struct GittyChatApp: App {
    @StateObject var gitter = Gitter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gitter)
                .onOpenURL { url in
                     if url.host == "oauth" {
                         OAuthSwift.handle(url: url)
                     }
//                    if let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
//                       let params = components.queryItems {
//                        if url.host == "oauth-callback" {
//                            OAuthSwift.handle(url: url)
//                        }
//                        gitter.showLoginView = false
//                        gitter.auth.authorize(code: params.first(where: { $0.name == "code" })?.value) { credential in
//                            gitter.login(credential: credential)
//                        }
//                    }
                }
        }
    }
}
