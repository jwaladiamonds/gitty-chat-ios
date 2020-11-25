//
//  InfinitProgressView.swift
//  GittyChat
//
//  Created by Nikhil John on 25/11/20.
//

import SwiftUI

struct InfinitProgressView: View {
    @State var progress: CGFloat = 0
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(UIColor.systemFill))
                    .frame(width: geo.size.width * 0.9, height: 4)
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.ruby)
                    .frame(width: geo.size.width * 0.2, height: 4)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    .offset(x: progress)
                    .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true))
                    .onAppear(perform: {
                        self.progress += geo.size.width * 0.7
                    })
            }
            .frame(height: 32)
            .padding(.horizontal, geo.size.width * 0.05)
        }
    }
}

struct InfinitProgressView_Previews: PreviewProvider {
    static var previews: some View {
        InfinitProgressView()
    }
}
