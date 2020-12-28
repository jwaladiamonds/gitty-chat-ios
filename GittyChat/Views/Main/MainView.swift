//
//  MainView.swift
//  GittyChat
//
//  Created by Nikhil John on 21/11/20.
//

import SwiftUI

struct MainView: View {
    private var screenWidth = UIScreen.main.bounds.width
    @State private var translationWidth: CGFloat = 0
    @State private var offsetProfile: CGFloat = -UIScreen.main.bounds.width
    var body: some View {
        ZStack {
            HomeView()
                .gesture(
                    DragGesture()
                        .onChanged {
                            self.translationWidth = $0.translation.width
                            if self.translationWidth > 0 {
                                self.offsetProfile = -screenWidth + $0.translation.width
                            }
                        }
                        .onEnded { _ in
                            if self.translationWidth > screenWidth/4 {
                                withAnimation(.easeOut(duration: 0.3)) {
                                    self.offsetProfile = 0
                                }
                            } else {
                                withAnimation(.easeOut(duration: 0.4)) {
                                    self.offsetProfile = -screenWidth
                                }
                            }
                        }
                )
            ProfileView()
                .offset(x: offsetProfile)
                .gesture(
                    DragGesture()
                        .onChanged {
                            self.translationWidth = $0.translation.width
                            if self.translationWidth < 0 {
                                self.offsetProfile = $0.translation.width
                            }
                        }
                        .onEnded { _ in
                            if self.translationWidth < -screenWidth/4 {
                                withAnimation(.easeOut(duration: 0.3)) {
                                    self.offsetProfile = -screenWidth
                                }
                            } else {
                                withAnimation(.easeOut(duration: 0.4)) {
                                    self.offsetProfile = 0
                                }
                            }
                        }
                )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
