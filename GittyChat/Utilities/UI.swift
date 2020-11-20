//
//  UI.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI

public extension Color {
    static let bodyText = Color("BodyText")
    static let ruby = Color("Ruby")
}

struct BodyText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.bodyText)
    }
}

struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.largeTitle.weight(.bold))
            .foregroundColor(.ruby)
    }
}

struct PrimaryButton: View {
    let title: String
    var action: () -> ()
    var body: some View {
        Button(action: action, label: {
            Text(title.uppercased())
                .fontWeight(.bold)
                .foregroundColor(.ruby)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(5)
        })
    }
}
