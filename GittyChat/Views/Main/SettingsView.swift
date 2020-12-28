//
//  SettingsView.swift
//  GittyChat
//
//  Created by Nikhil John on 28/12/20.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Developed by")
                Link("@nikzjon".capitalized, destination: URL(string: "https://github.com/nikhiljohn10")!)
            }
        }.frame(maxWidth: .infinity)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
