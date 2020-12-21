//
//  PrimaryButton.swift
//  GittyChat
//
//  Created by Nikhil John on 28/11/20.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var action: () -> ()
    var body: some View {
        Button(action: action, label: {
            Text(title.uppercased())
                .fontWeight(.bold)
                .foregroundColor(Color.accentColor)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(5)
        })
    }
}

struct LoginButton: View {
    let title: String
    let url: URL?
    @Binding var show: Bool
    var body: some View {
        Button(action: {
            show = true
        }, label: {
            Text(title.uppercased())
                .fontWeight(.bold)
                .foregroundColor(Color.accentColor)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(5)
                .fullScreenCover(isPresented: $show) {
                    SafariView(url: url!).edgesIgnoringSafeArea(.all)
                }
        })
    }
}
