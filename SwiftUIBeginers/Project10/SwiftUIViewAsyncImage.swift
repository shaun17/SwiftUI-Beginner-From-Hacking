//
//  SwiftUIViewAsyncImage.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/6.
//

import SwiftUI

struct SwiftUIViewAsyncImage: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in

            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was a error loading the image")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    SwiftUIViewAsyncImage()
}
