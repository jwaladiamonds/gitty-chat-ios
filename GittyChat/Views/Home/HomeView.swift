//
//  HomeView.swift
//  GittyChat
//
//  Created by Nikhil John on 21/11/20.
//

import SwiftUI


struct HomeView: View {
    @EnvironmentObject var gitter: Gitter
    var body: some View {
        NavigationView {
            VStack {
                List {
                    
                    Section(header: ListHeader(text: "Favorite")) {
                        if let rooms = gitter.rooms {
                            ForEach(favouriteRooms(rooms: rooms), id: \.id) { room in
                                RowItem(text: room.name)
                            }
                        }
                    }

                    Section(header: ListHeader(text: "Rooms")) {
                        if let rooms = gitter.rooms {
                            ForEach(rooms, id: \.id) { room in
                                RowItem(text: room.name)
                            }
                        }
                    }
                    
                    Section(header: ListHeader(text: "Communities")) {
                        if let groups = gitter.groups {
                            ForEach(groups, id: \.id) { group in
                                RowItem(text: group.name)
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle("Home")
            .navigationBarItems(
                leading:
                    NavigationLink(destination: ProfileView()) {
                        Group {
                            if let user = gitter.user {
                                ImageView(url: user.avatarUrlSmall!)
                            }
                        }
                        .clipShape(Circle())
                        .frame(width: 30, height: 30)
                    }
            )
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button(action: {}) {
                            Label("Create community", systemImage: "person.2.square.stack")
                        }

                        Button(action: {}) {
                            Label("Create room", systemImage: "person.crop.square")
                        }
                    }
                    label: {
                        Image(systemName: "plus.app")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.vertical)
                    }
                }
            }
        }
    }
    
    func favouriteRooms(rooms: [GRoom]) -> [GRoom] {
        var favRooms = [GRoom]()
        rooms.forEach { room in
            if room.favourite != nil {
                favRooms.append(room)
            }
        }
        return favRooms.sorted {
            if let oldFav = $0.favourite, let newFav = $1.favourite {
                return oldFav > newFav
            }
            return false
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
    }
}

struct RowItem: View {
    var text: String = "Test link"
    var body: some View {
        NavigationLink(destination: Text(text)) {
            HStack {
                Text(text)
            }
        }
    }
}
