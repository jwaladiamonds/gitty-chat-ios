//
//  ContentView.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var gitter: Gitter
    @State var email = ""
    @State var password = ""
    @State var error: String?
    
    var body: some View {
        NavigationView {
          VStack {
//            TextField("Email", text: $email, onCommit: validate)
//              .padding()
//              .textFieldStyle(RoundedBorderTextFieldStyle())
//              .keyboardType(.emailAddress)
//            SecureField("Password", text: $password, onCommit: validate)
//              .padding()
//              .textFieldStyle(RoundedBorderTextFieldStyle())
//            Button(action: login) {
//              Text("Sign in")
//            }.disabled(error != nil)
//            error.flatMap {
//              Text("Error: \($0)").foregroundColor(.red)
//            }
            Button("Gitter"){
                gitter.openAuthURL()
            }
          }.navigationBarTitle("Log In")
        }
    }
    func validate() {
        
    }
    func login() {
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
