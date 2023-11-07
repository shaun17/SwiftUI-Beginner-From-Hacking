//
//  SwiftUIViewResponse.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/6.
//

import SwiftUI

struct Response: Codable {
    var result: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct SwiftUIViewResponse: View {
    @State public var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
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
            
            print(data)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.result
            }
            
        } catch {
            print("Invalid URL")
        }
    }
}

#Preview {
    SwiftUIViewResponse()
}
