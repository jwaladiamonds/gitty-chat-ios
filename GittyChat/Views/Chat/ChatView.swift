//
//  ChatView.swift
//  GittyChat
//
//  Created by Nikhil John on 27/11/20.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        Text("Hello World!")
    }
}

struct MessageField: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var height: CGFloat
    var placeholder = "Message"
    
    func makeCoordinator() -> Coordiator {
        return MessageField.Coordiator(parent: self, placeholder: placeholder)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.isScrollEnabled = true
        view.text = placeholder
        view.font = .systemFont(ofSize: 18)
        view.textColor = .lightGray
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = self.text
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
        }
    }
    
    class Coordiator: NSObject, UITextViewDelegate {
        var parent: MessageField
        var placeholder: String
        
        init(parent: MessageField, placeholder: String) {
            self.parent = parent
            self.placeholder = placeholder
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.parent.text == "" {
                textView.text = ""
                textView.textColor = .label
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if self.parent.text == "" {
                textView.text = placeholder
                textView.textColor = .lightGray
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.text = textView.text
            }
        }
    }
}

struct ChatField: View {
    
    @Binding var text: String
    @State var height: CGFloat = 0
    var sendText: () -> ()
    
    var body: some View {
        HStack(alignment: .bottom) {
            MessageField(text: self.$text, height: self.$height)
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
//                    .foregroundColor(C)
            })
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct ChatRoom: View {
    
    @State var text = ""
    @State var height: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Chat Room")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
            .background(Color(.systemBackground))
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(0 ..< 60) { item in
                        Text("Hello \(item+1)")
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ChatField(text: $text, height: height) {
                print("Sending following text:")
                print(self.text)
            }
            .background(Color(.systemBackground).edgesIgnoringSafeArea(.bottom))
        }
        .background(Color(.systemGroupedBackground))
        .onTapGesture {
            UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
        }
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom(height: 38)
    }
}
