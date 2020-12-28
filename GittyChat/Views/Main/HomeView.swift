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
