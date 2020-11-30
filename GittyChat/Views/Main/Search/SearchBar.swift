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
    @Binding var showResults: Bool
//    @Binding var loadSearch: Bool
    var body: some View {
        HStack(spacing: 0) {
            HStack {
                TextField("Search", text: $searchText)
                    .padding(.leading, 24)
            }
            .frame(height: 4.0)
            .padding()
            .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(.horizontal)
            .onTapGesture {
                isSearching = true
                showResults = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    Button(action: {
                      searchText = ""
                    }) {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.gray)
                            .opacity(isSearching ? 1 : 0)
                        
                    }
                }
                .padding(.horizontal, 28.0)
                .foregroundColor(.gray)
            )
            .animation(.spring())
//            .animation(loadSearch ? .spring() : .none )
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    showResults = false
                    
                    UIApplication.shared
                        .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, 0)
                }
                .transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""), isSearching: .constant(true), showResults: .constant(true))
    }
}
