//
//  ImageView.swift
//  GittyChat
//
//  Created by Nikhil John on 23/11/20.
//

import SwiftUI

struct ImageView: View {

    private class Loader: ObservableObject {
        var data = Data()

        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }

            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    @State private var image: Image = Image(systemName: "person.crop.circle.fill")

    var body: some View {
        if let image = UIImage(data: loader.data) {
            Image(uiImage: image)
                .resizable()
        } else {
            ProgressView()
        }
    }

    init(url: String) {
        _loader = StateObject(wrappedValue: Loader(url: url))
    }
}
