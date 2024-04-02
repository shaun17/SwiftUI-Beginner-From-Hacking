//
//  ChallengeMilstone13-15.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/1.
//

import PhotosUI
import SwiftUI
import SwiftData

struct NamedImage: Codable, Identifiable {
    var id = UUID()
    let name: String
    let imageData: Data // 使用Data类型来存储图像数据

    // Image不是Codable的，所以不直接包含在结构体中
    // 而是提供一个计算属性来从imageData创建Image
    var image: Image? {
        if let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        }
        return nil
    }
    
}

@Observable
class ImageStore {
    var images: [NamedImage] = []
    let savePath = URL.documentsDirectory.appending(path: "SavedPicPlaces")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            images = try JSONDecoder().decode([NamedImage].self, from: data)
            sortImages()
        } catch {
            images = []
        }
    }

    func addImage(named name: String, imageData: Data) {
        let newImage = NamedImage(name: name, imageData: imageData)
        images.append(newImage)
        sortImages()
        save()
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(images)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func sortImages() {
            images.sort { $0.name < $1.name }
        }
}

struct ChallengeMilstone13_15: View {
    @Bindable var imageStore = ImageStore()
    @State private var showingImportView = false
    
    
    var body: some View {
        NavigationStack {
            List(imageStore.images) { img in
                NavigationLink(destination: ImageDetailView(namedImage: img)) {
                    Text(img.name)
                }
            }
            .navigationTitle("图片库")
            .toolbar {
                Button("导入图片") {
                    showingImportView = true
                }
            }
            .sheet(isPresented: $showingImportView) {
                ImportImageView(imageStore: imageStore)
            }
        }
    }
}

struct ImportImageView: View {
    @Bindable var imageStore: ImageStore
    @Environment(\.dismiss) var dismiss
    @State private var pickerItem: PhotosPickerItem?
    @State private var imageName: String = ""
    @State private var currentImage: Image?
    @State private var currentData: Data?
    @State private var errorMsg = ""

    var body: some View {
        NavigationStack{
            VStack {
                if !errorMsg.isEmpty {
                    HStack {
                        Image(systemName: "nosign")
                        Text(errorMsg)
                            .font(.subheadline)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                Section("Details") {
                    TextField("图片名称", text: $imageName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        

                    
                    if let currentImage {
                        currentImage
                            .resizable()
                            .scaledToFit()
                    }
                    PhotosPicker(selection: $pickerItem, matching: .images) {
                        Label("选择图片", systemImage: "photo")
                    }
                    .onChange(of: pickerItem) {
                        Task {
                            guard let data = try? await pickerItem?.loadTransferable(type: Data.self),
                                  let uiImage = UIImage(data: data) else { return }
                            let image = Image(uiImage: uiImage)
                            currentData = data
                            currentImage = image
                        }
                    }
                }
            }
            .toolbar{
                Button("Save") {
                    if currentImage != nil, !imageName.isEmpty {
                        imageStore.addImage(named: imageName, imageData: currentData!)
                        dismiss()
                    } else {
                        errorMsg = "Name and Pic can not be empty "
                    }
                }
            }
            .padding()
        }
    }
}

struct ImageDetailView: View {
    let namedImage: NamedImage

    var body: some View {
        namedImage.image?
            .resizable()
            .scaledToFit()
            .navigationTitle(namedImage.name)
    }
}

#Preview {
    ChallengeMilstone13_15()
}
