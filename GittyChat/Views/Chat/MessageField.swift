//
//  MessageField.swift
//  GittyChat
//
//  Created by Nikhil John on 22/12/20.
//

import SwiftUI

struct MessageField: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var height: CGFloat
    var placeholder: String
    @State var isEditing: Bool = false
    
    func makeCoordinator() -> Coordiator {
        return MessageField.Coordiator(parent: self)
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
    
    func updateUIView(_ textView: UITextView, context: Context) {
        if self.text == "" {
            textView.text = self.isEditing ? "" : self.placeholder
            textView.textColor = self.isEditing ? .label : .lightGray
        }
        DispatchQueue.main.async {
            self.height = textView.contentSize.height
        }
    }
    
    class Coordiator: NSObject, UITextViewDelegate {
        var parent: MessageField
        
        init(parent: MessageField) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.isEditing = true
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.isEditing = false
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
