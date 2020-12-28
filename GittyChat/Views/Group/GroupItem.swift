//
//  GroupItem.swift
//  GittyChat
//
//  Created by Nikhil John on 28/12/20.
//

import SwiftUI

struct GroupItem: View {
    var group: GGroup
    var body: some View {
        NavigationLink(destination: GroupView(group: group)) {
            HStack {
                Group {
                    if let url = group.avatarUrl {
                        ImageView(url: url)
                    } else {
                        Image(systemName: "person.2.fill")
                    }
                }
                .clipShape(Circle())
                .frame(width: 32, height: 32)
                .padding(.trailing, 4)
                Text(group.name)
            }
            .padding(.vertical, 10)
        }
    }
}
