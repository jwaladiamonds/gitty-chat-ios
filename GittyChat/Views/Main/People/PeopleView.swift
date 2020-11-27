//
//  PeopleView.swift
//  GittyChat
//
//  Created by Nikhil John on 21/11/20.
//

import SwiftUI

struct PeopleView: View {
    var body: some View {
        NavigationView {
            Text("People")
                .navigationBarTitle("People")
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
