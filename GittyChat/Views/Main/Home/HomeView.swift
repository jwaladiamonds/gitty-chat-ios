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
                    
                    Section(header: ListHeader(text: "Favorites")) {
                        if let rooms = gitter.rooms {
                            ForEach(favouriteRooms(rooms: rooms), id: \.id) { room in
                                RoomItem(room: room)
                            }
                        } else {
                            InfinitProgressView()
                        }
                    }

                    Section(header: ListHeader(text: "Rooms")) {
                        if let rooms = gitter.rooms {
                            ForEach(sortedRooms(rooms: rooms), id: \.id) { room in
                                RoomItem(room: room)
                            }
                        } else {
                            InfinitProgressView()
                        }
                    }
                    
                    Section(header: ListHeader(text: "Communities")) {
                        if let groups = gitter.groups {
                            ForEach(groups, id: \.id) { group in
                                GroupItem(group: group)
                            }
                        } else {
                            InfinitProgressView()
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle("Home")
            .navigationBarItems(
                leading:
                    Group {
                        if let user = gitter.user {
                            NavigationLink(destination: ProfileView(user: user)) {
                                Group {
                                    ImageView(url: user.avatarUrlSmall!)
                                }
                                .clipShape(Circle())
                                .frame(width: 30, height: 30)
                            }
                        }
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
            if let nextFav = $0.favourite, let thisFav = $1.favourite {
                return nextFav < thisFav
            }
            return false
        }
    }
    
    func sortedRooms(rooms: [GRoom]) -> [GRoom] {
        return rooms.sorted {
            if let nextFav = $0.lastAccessTime, let thisFav = $1.lastAccessTime {
                return nextFav > thisFav
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
            .padding(.vertical, 7)
    }
}
