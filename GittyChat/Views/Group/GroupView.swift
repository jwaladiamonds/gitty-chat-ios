//
//  GroupView.swift
//  GittyChat
//
//  Created by Nikhil John on 25/11/20.
//

import SwiftUI

struct GroupView: View {
    var group: GGroup
    var body: some View {
        VStack {
            if let url = group.avatarUrl {
                ImageView(url: url)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            }
            Text(group.name)
        }
    }
}
