//
//  Pro10Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/20.
//

import SwiftUI

struct ResponsePro10: Codable {
    var results: [ResultPro10]
}

struct ResultPro10: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct Pro10Part1: View {
    @State private var results = [ResultPro10]()
    
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }

    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image.resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
                
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
        
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
            .disabled(disableForm)
        }
        
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading, content: {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            })
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(ResponsePro10.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    Pro10Part1()
}
