//
//  WelcomeView.swift
//  GittyChat
//
//  Created by Nikhil John on 20/11/20.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var gitter: Gitter
    var body: some View {
        VStack(alignment: .leading) {
            Text("Where comminities thrive")
                .modifier(TitleText())
                .padding()
                .padding(.top, 70)
            Spacer()
            VStack(alignment: .center) {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(40)
                    .padding(.bottom, 35)
                    .padding([.leading, .trailing], 80)
                PrimaryButton(title: "Sign in with Gitter") {
                    gitter.auth.openAuthURL()
                }
            }
            Spacer()
        }
        .background(Color(UIColor.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
