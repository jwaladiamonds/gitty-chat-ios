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


