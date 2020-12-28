//
//  SearchBar.swift
//  GittyChat
//
//  Created by Nikhil John on 30/11/20.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    var body: some View {
        HStack(spacing: 0) {
            TextField("Search", text: $searchText)
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
            .background(Color(.systemGray5))
            .foregroundColor(Color(.label))
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
            .onTapGesture {
                isSearching = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(10)
                    Spacer()
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .opacity(isSearching ? 1 : 0)
                            .padding(10)
                    }
                }
                .foregroundColor(Color(.systemGray))
            )
            .animation(.spring())
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    UIApplication.shared
                        .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                        .padding(.leading, 10)
                        .foregroundColor(Color.accentColor)
                }
                .transition(AnyTransition.opacity.combined(with: .move(edge: .trailing)))
                .animation(.spring())
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""), isSearching: .constant(true))
    }
}
