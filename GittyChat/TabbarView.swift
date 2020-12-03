//
//  TabbarView.swift
//  GittyChat
//
//  Created by Nikhil John on 01/12/20.
//

import SwiftUI

struct TabbarView: View {
    @State private var selection = 0
    @State private var isActive = false
    @EnvironmentObject var uiModel: UIModel
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                NavigationView {
                    List(1...10, id: \.self) { index in
                        NavigationLink(
                            destination: Text("Item #\(index) Details"),
                            isActive: $uiModel.tabActive,
                            label: {
                                Text("Car #\(index)")
                            })
                    }
                    .navigationTitle("Inner View")
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)
                NavigationView {
                    List(1...10, id: \.self) { index in
                        NavigationLink(
                            destination: Text("Item #\(index) Details"),
                            isActive: $isActive,
                            label: {
                                Text("Item #\(index)")
                            })
                    }
                    .navigationTitle("Inner View 2")
                }
                .tabItem {
                    Image(systemName: "video.circle.fill")
                    Text("Video")
                }.tag(1)
            }
            .accentColor(.red)
            .navigationTitle("TabView Demo")
            .onTapGesture(count: 2, perform: {
                isActive = false
            })
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
