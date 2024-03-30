//
//  Pro13Part3.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/28.
//

import SwiftUI
import PhotosUI

struct Pro13Part3: View {
    @State private var pickerItem = [PhotosPickerItem]()
    @State private var selectImage = [Image]()
    
    var body: some View {
        VStack{
            let example = Image(.horror)
            
            ShareLink(item: example, preview: SharePreview("Horror", image: example)){
                Label("Click to share", systemImage: "airplane")

            }
            
            ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
                Label("Spread the word about Swift", systemImage: "swift")
            }
            
            PhotosPicker("Select a Pic", selection: $pickerItem, maxSelectionCount: 3, matching: .images)
            ForEach(0..<selectImage.count, id: \.self){ img in
                selectImage[img]
                    .resizable().scaledToFit()
                
            }
            
        }
        .onChange(of: pickerItem) {
            Task{
                selectImage.removeAll()

                for item in pickerItem {
                    if let image = try await item.loadTransferable(type: Image.self){
                        selectImage.append(image)
                    }
                }
//                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)

            }
        }
    }
}

#Preview {
    Pro13Part3()
}
