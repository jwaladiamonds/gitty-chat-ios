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

struct LoadingAnimation: View {
    var isLoading: Bool
    var body: some View {
        ZStack {
 
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 14)
                .frame(width: 100, height: 100)
 
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(Color.green, lineWidth: 7)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
        }
    }
}

struct ListHeader: View {
    var text: String = ""
    var body: some View {
        Text(text)
            .foregroundColor(Color(UIColor.label))
            .textCase(.none)
            .font(.system(size: 20, weight: .semibold, design: .default))
            .padding(.vertical, 7)
    }
}
