//
//  Pro9Part3.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/19.
//

import SwiftUI

struct DetailView2: View {
    @State var number: Int
    @State var path:PathStore

    var body: some View{
        NavigationLink("Go to Random Number", value: Int.random(in: 0..<99))
            .navigationTitle("Number: \(number)")
            .toolbar(content: {
                Button("Home") {
                    path.removeAll()
                }
            })
            
    }
}


struct Pro9Part3: View {
    @State private var pathStore = PathStore()
    var body: some View {
        NavigationStack(path: $pathStore.path, root: {
            DetailView2(number: 0,path: pathStore)
                .navigationDestination(for: Int.self) { i in
                    DetailView2(number: i,path: pathStore)
                }
                
        })
    }
}

@Observable
class PathStore {
    var path: [Int] {
        didSet {
            save()
        }
    }

    private let savePath = URL.documentsDirectory.appending(path: "SavePath")

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoder = try? JSONDecoder().decode([Int].self, from: data) {
                path = decoder
                return
            }
        }
        path = []
    }

    func save() {
        do {
            let encoder = try JSONEncoder().encode(path)
            try encoder.write(to: savePath)
        } catch {
            print("Failed to save navigation data")

        }
    }
    
    func removeAll() {
        path = []
    }
}

@Observable
class PatshStoreNavigationPath{
    var path: NavigationPath{
        didSet{
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavePath")
    init(){
        if let data = try? Data(contentsOf: savePath) {
            if let decoder = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self , from: data) {
                path = NavigationPath(decoder)
                return
            }
        }
        path = NavigationPath()

    }

    func save(){
        guard let representation = path.codable else {return}
        
        do{
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        }catch {
            print("Failed to save navigation data")

        }
    }
}
#Preview {
    Pro9Part3()
}
