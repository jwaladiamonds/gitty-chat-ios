//
//  SearchView.swift
//  GittyChat
//
//  Created by Nikhil John on 21/11/20.
//

import SwiftUI

struct SearchView: View {
    @State var searchText: String = ""
    @State var isSearching: Bool = false
    @State var showResults: Bool = false
    var body: some View {
        ScrollView {
            VStack {
                SearchBar(searchText: $searchText, isSearching: $isSearching, showResults: $showResults)
                Text("Search")
                    .navigationBarTitle("Search")
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
