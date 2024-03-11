//
//  ChallengeUserView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/24.
//

import SwiftUI

struct ChallengeUserView: View {
    @State public var results = [ChallengeUser]()

    var body: some View {
        NavigationView(content: {
            List(results) { item in
                VStack {
                    NavigationLink(destination: Text(item.about)
                        .font(.headline)) { Text(item.name) }

                   
                }
            }
            .task {
                if let retrievedUsers = await loadData() {
                    results = retrievedUsers
                }
            }
        })
        
    }
    
    func loadData() async -> [ChallengeUser]? {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([ChallengeUser].self, from: data) {
                return decodedResponse
            }
            
        } catch {
            print("Invalid URL")
        }
        return nil
    }
}

#Preview {
    ChallengeUserView()
}
