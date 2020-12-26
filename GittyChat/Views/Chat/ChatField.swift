//
//  ChatField.swift
//  GittyChat
//
//  Created by Nikhil John on 22/12/20.
//

import SwiftUI


struct ChatField: View {
    
    @Binding var text: String
    @State var height: CGFloat = 0
    var placeholder = "Enter a message"
    var sendText: () -> ()
    
    var body: some View {
        HStack(alignment: .bottom) {
            MessageField(text: self.$text, height: self.$height, placeholder: placeholder)
                .frame(height: self.height < 150 ? self.height : 150)
                .padding(.horizontal)
                .background(Color(.systemBackground))
                .cornerRadius(10)
            Button(action: {
                self.sendText()
                self.text = ""
                print("Message sent")
            }, label: {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(12)
                    .frame(height: 38, alignment: .center)
            })
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}


struct ChatField_Previews: PreviewProvider {
    static var previews: some View {
        ChatField(text: .constant(""), height: 38, placeholder: "Message") {
            print("Message sent")
        }
    }
}
