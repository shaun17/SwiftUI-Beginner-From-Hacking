//
//  Pro13Part2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/28.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct DoNotClick: View {
    var body: some View {
        ContentUnavailableView {
            Label("No snippets", systemImage: "swift")
        } description: {
            Text("You don't have any saved snippets yet.")
        } actions: {
            Button("Create Snippet") {
                // create a snippet
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct Pro13Part2: View {
    @State private var image: Image?
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    DoNotClick()
//                    ContentUnavailableView("No snippets", systemImage: "pencil" , description: Text("You don't have any saved snippets yet."))
                } label: {
                    Text("DO NOT CLICK")
                }

                image?
                    .resizable()
                    .scaledToFit()
            }
            .onAppear(perform: {
                loadImage()
            })
        }
    }

    func loadImage() {
        let inputImage = UIImage(resource: .horror)
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
//        let currentFilter = CIFilter.sepiaTone()
//        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 7

//        let currentFilter = CIFilter.pixellate()
//        currentFilter.inputImage = beginImage
//        currentFilter.scale = 20

//        let currentFilter = CIFilter.crystallize()
//        currentFilter.inputImage = beginImage
//        currentFilter.radius = 10

//        let currentFilter = CIFilter.twirlDistortion()
//        currentFilter.inputImage = beginImage
//        currentFilter.radius = 1000
//        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)

        let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage

        let amount = 1.0

        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiiImage)

//        image = Image(.horror)
    }
}

#Preview {
    Pro13Part2()
}
