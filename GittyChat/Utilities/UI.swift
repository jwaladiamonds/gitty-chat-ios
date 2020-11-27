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

struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.largeTitle.weight(.bold))
            .foregroundColor(Color.accentColor)
    }
}

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

struct PlainGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .font(.system(size: 18, weight: .semibold, design: .default))
            VStack(alignment: .leading) {
                configuration.content
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .padding()
    }
}

struct ListHeader<Waiter>: View {
    @EnvironmentObject var gitter: Gitter
    var text: String = ""
    var waitFor: Waiter?
    var body: some View {
        HStack(spacing: 10) {
            Text(text)
                .foregroundColor(Color(UIColor.label))
                .textCase(.none)
                .font(.system(size: 20, weight: .semibold, design: .default))
                .padding(.vertical, 7)
            if waitFor == nil {
                ProgressView()
            }
        }
    }
}
