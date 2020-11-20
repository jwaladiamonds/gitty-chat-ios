//
//  WelcomeView.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create an account")
            Text("Connect with people around the world")
                .font(Font.largeTitle.weight(.bold))
                .foregroundColor(.accentColor)
            Spacer()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
