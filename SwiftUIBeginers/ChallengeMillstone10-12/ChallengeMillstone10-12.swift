//
//  ChallengeMillstone10-12.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/27.
//

import Foundation
import SwiftUI

// 定义匹配JSON的User结构体
struct UserChallenge: Codable, Identifiable, Hashable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [FriendChallenge]
}

// 定义匹配JSON中friends数组的Friend结构体
struct FriendChallenge: Codable, Hashable {
    var id: String
    var name: String
}

@Observable
class UsersViewModel: Hashable, Identifiable {
    static func == (lhs: UsersViewModel, rhs: UsersViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(users)
    }

    var users = [UserChallenge]()

    func fetchUsers() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let decodedUsers = try? JSONDecoder().decode([UserChallenge].self, from: data) {
                    DispatchQueue.main.async {
                        self.users = decodedUsers
                    }
                }
            } else {
                print("Error fetching users: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}

struct ChallengeMillstone10_12: View {
    var viewModel = UsersViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Age: \(user.age), Company: \(user.company)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Text("acticve: \(user.isActive ? "⭕️" : "❌"), email: \(user.email)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding()
                .cornerRadius(15)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.random)
            }
            .navigationTitle("FriendFace")
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    ChallengeMillstone10_12()
}
