//
//  HomeView.swift
//  GittyChat
//
//  Created by Nikhil John on 21/11/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var gitter: Gitter
    var body: some View {
        Button("Logout") {
            gitter.logout()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
