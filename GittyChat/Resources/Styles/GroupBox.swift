//
//  GroupBox.swift
//  GittyChat
//
//  Created by Nikhil John on 28/11/20.
//

import SwiftUI

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
