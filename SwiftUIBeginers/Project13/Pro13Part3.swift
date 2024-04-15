//
//  Pro13Part3.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/28.
//

import PhotosUI
import SwiftUI

struct Pro13Part3: View {
    @State private var pickerItem = [PhotosPickerItem]()
    @State private var selectImage = [Image]()

    @State private var showingShareSheet = false

    var body: some View {
        VStack {
            Image(.horror)
                .onLongPressGesture {
                    self.showingShareSheet = true
                }
                .actionSheet(isPresented: $showingShareSheet, content: {
                    ActionSheet(title: Text("Share"), message: Text("方式"), buttons: [.default(Text("立即分享")) {
                            share()
                        },
                        .cancel(),
                        ])
                })

            let example = Image(.horror)

            ShareLink(item: example, preview: SharePreview("Horror", image: example)) {
                Label("Click to share", systemImage: "airplane")
            }

            ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
                Label("Spread the word about Swift", systemImage: "swift")
            }

            PhotosPicker("Select a Pic", selection: $pickerItem, maxSelectionCount: 3, matching: .images)
            ForEach(0 ..< selectImage.count, id: \.self) { img in
                selectImage[img]
                    .resizable().scaledToFit()
            }
        }
        .onChange(of: pickerItem) {
            Task {
                selectImage.removeAll()

                for item in pickerItem {
                    if let image = try await item.loadTransferable(type: Image.self) {
                        selectImage.append(image)
                    }
                }
//                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
    }

    func share() {}
}

#Preview {
    Pro13Part3()
}
