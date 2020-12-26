//
//  HomeView.swift
//  GittyChat
//
//  Created by Nikhil John on 21/11/20.
//

import SwiftUI


struct HomeView: View {
    @EnvironmentObject var gitter: Gitter
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    var body: some View {
        List {
            Section(header: ListHeader(text: "Rooms", waitFor: gitter.rooms)) {
                ForEach(sortedRooms(rooms: gitter.rooms), id: \.id) { room in
                    RoomItem(room: room)
                }
            }
            
            Section(header: ListHeader(text: "Communities", waitFor: gitter.groups)) {
                if let groups = gitter.groups {
                    ForEach(groups, id: \.id) { group in
                        GroupItem(group: group)
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("Home"))
        .navigationBarTitleDisplayMode(.large)
//        .navigationTitle(Text("Home"))
//        .toolbar {
//            ToolbarItem(placement: .primaryAction) {
//                Menu {
//                    Button(action: {}) {
//                        Label("Create community", systemImage: "person.2.square.stack")
//                    }
//
//                    Button(action: {}) {
//                        Label("Create room", systemImage: "person.crop.square")
//                    }
//
//                    Button(action: {
//                        gitter.logout()
//                    }) {
//                        Label("Logout", systemImage: "multiply.circle")
//                    }
//                }
//                label: {
//                    Image(systemName: "plus.app")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .padding(.vertical)
//                }
//            }
//        }
        //        .background(
        //            SearchBar(searchText: $searchText, isSearching: $isSearching))
    }
    
    func sortedRooms(rooms: [GRoom]?) -> [GRoom] {
        var favRooms = [GRoom]()
        var unfavRooms = [GRoom]()
        if let rooms = rooms {
            rooms.forEach { room in
                if room.favourite != nil {
                    favRooms.append(room)
                } else {
                    unfavRooms.append(room)
                }
            }
        }
        return favRooms.sorted {
            if let nextFav = $0.favourite, let thisFav = $1.favourite {
                return nextFav < thisFav
            }
            return false
        } + unfavRooms.sorted {
            if let nextAccess = $0.lastAccessTime, let thisAccess = $1.lastAccessTime {
                return nextAccess > thisAccess
            }
            return false
        }
    }
    
}
