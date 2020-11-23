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
        VStack {
            
            
        }
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("Logout") {
                    gitter.logout()
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
