//
//  HomeView.swift
//  GittyChat
//
//  Created by Nikhil John on 21/11/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var gitter: Gitter
    @State private var sort: Int = 0
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    GroupBox(label: Text("My Work")) {
                        NavigationLink(destination: Text("New World")) {
                            Text("Hello, new World!")
                        }
                        NavigationLink(destination: Text("New World")) {
                            Text("Hello, new World!")
                        }
                        NavigationLink(destination: Text("New World")) {
                            Text("Hello, new World!")
                        }
                        NavigationLink(destination: Text("New World")) {
                            Text("Hello, new World!")
                        }
                    }
                    .groupBoxStyle(PlainGroupBoxStyle())
                }
            }
            .navigationBarTitle("Home")
            .navigationBarItems(
                leading:
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
            )
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button(action: {}) {
                            Label("Create community", systemImage: "person.2.square.stack")
                        }

                        Button(action: {}) {
                            Label("Create room", systemImage: "person.crop.square")
                        }
                    }
                    label: {
                        Image(systemName: "plus.app")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.vertical)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
