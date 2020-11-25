//
//  ProfileView.swift
//  GittyChat
//
//  Created by Nikhil John on 23/11/20.
//

import SwiftUI


struct ProfileView: View {
    @EnvironmentObject var gitter: Gitter
    var user: GUser
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Group {
                        if let url = user.avatarUrl {
                            ImageView(url: url)
                        } else if let url = user.avatarUrlMedium {
                            ImageView(url: url)
                        } else if let url = user.avatarUrlSmall {
                            ImageView(url: url)
                        } else {
                            Image(systemName: "person.fill")
                        }
                    }
                    .clipShape(Circle())
                    .frame(width: 80, height: 80)
                    VStack {
                        Text(user.displayName)
                            .font(.title)
                    }
                }
//                Text("Role: \(user.role ?? "None")")
//                Text("Staff: \(user.staff ?? false ? "True" : "False")")
                if let providers = user.providers {
                    VStack {
                        ForEach(providers, id: \.self) { provider in
                            HStack {
                                Text("\(provider) : ")
                                Link("https://\(provider).com\(user.url)", destination: URL(string: "https://\(provider).com\(user.url)")!)
                            }
                        }
                    }
                }
//                Text("Version: \(user.v ?? 0)")
//                Text("Github version: \(user.gv ?? "nil")")
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .navigationBarTitle("@\(user.username)")
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("Logout") {
                    gitter.logout()
                }
            }
        }
    }
}
