//
//  List.swift
//  GittyChat
//
//  Created by Nikhil John on 28/11/20.
//

import SwiftUI

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
