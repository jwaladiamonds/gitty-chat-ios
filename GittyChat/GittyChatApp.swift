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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gitter)
                .onOpenURL { url in
                    if let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
                       let params = components.queryItems {
                        gitter.auth.authorize(code: params.first(where: { $0.name == "code" })?.value) { credential in
                            gitter.login(credential: credential)
                        }
                    }
                }
                .onAppear {
                    gitter.auth.load { credential in
                        gitter.credential = credential
                    }
                }
        }
    }
}
