//
//  WelcomeView.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create an account")
                .modifier(BodyText())
                .padding()
            Text("Connect with people around the world")
                .modifier(TitleText())
                .padding([.bottom, .leading, .trailing])
            VStack(alignment: .center) {
                Image("Logo")
                     .padding(.bottom, 35)
                     .padding([.leading, .trailing], 80)
                Text("This is a sample app.Create an account or login to begin chatting.")
                    .modifier(BodyText())
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 40)
            }
            Spacer()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
