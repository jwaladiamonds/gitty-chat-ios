//
//  ProfileView.swift
//  GittyChat
//
//  Created by Nikhil John on 23/11/20.
//

import SwiftUI


struct ProfileView: View {
    @EnvironmentObject var gitter: Gitter
    var body: some View {
        NavigationView {
            List {
                if let user = gitter.user {
                    Section {
                        VStack(alignment: .leading) {
                            HStack(spacing: 20) {
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
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(user.displayName)
                                        .font(.title)
                                    Text("@\(user.username)")
                                        .foregroundColor(.ruby)
                                        .onTapGesture(perform: {
                                            shareURL(url: "https://gitter.im\(user.url)")
                                        })
                                }
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    Section(header: ListHeader(text: "Providers", waitFor: user.providers)) {
                        if let providers = user.providers {
                            ForEach(providers, id: \.self) { provider in
                                Link("\(provider)".capitalized, destination: URL(string: "https://\(provider).com\(user.url)")!)
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .navigationBarTitle("Profile", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button("Logout") {
                        gitter.logout()
                    }
                }
            }
            .background(Group {
                if gitter.user == nil {
                    ProgressView()
                }
            })
            .ignoresSafeArea(.all, edges: .all)
        }
    }
    
    func shareURL(url: String) {
        guard let data = URL(string: url) else { return }
        let avc = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
    }
}
