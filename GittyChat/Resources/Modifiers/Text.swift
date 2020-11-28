//
//  Text.swift
//  GittyChat
//
//  Created by Nikhil John on 28/11/20.
//

import SwiftUI

struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.largeTitle.weight(.bold))
            .foregroundColor(Color.accentColor)
    }
}

