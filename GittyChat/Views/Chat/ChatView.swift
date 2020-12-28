//
//  ChatView.swift
//  GittyChat
//
//  Created by Nikhil John on 27/11/20.
//

import SwiftUI

struct ChatView: View {
    var room: GRoom
    @State private var text = ""
    @EnvironmentObject var gitter: Gitter
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    VStack(alignment: .leading) {
                        ForEach(0 ..< 60) { item in
                            Text("Hello \(item+1)")
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitle(room.name, displayMode: .inline)
        .onTapGesture {
            UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
        }
    }
}

    var body: some View {
            }
            }
        }
    }
}
