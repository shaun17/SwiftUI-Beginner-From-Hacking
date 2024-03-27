//
//  ChallengeMillstone10-12.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/27.
//

import SwiftData

import SwiftUI

extension DateFormatter {
    static let customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // 根据你的日期字符串格式调整
        return formatter
    }()
}
// 定义匹配JSON的User结构体
@Model
class UserChallenge: Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [FriendChallenge]

    init(id: String, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: Date, tags: [String], friends: [FriendChallenge]) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
    private enum CodingKeys: String, CodingKey {
        case id, name, isActive, age, company, email, address, about, registered, tags, friends
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        
        let registeredString = try container.decode(String.self, forKey: .registered)
        if let date = DateFormatter.customDateFormatter.date(from: registeredString) {
            registered = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .registered, in: container, debugDescription: "日期格式不正确")
        }        
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decode([FriendChallenge].self, forKey: .friends)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.isActive, forKey: .isActive)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.company, forKey: .company)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.about, forKey: .about)
        try container.encode(self.registered, forKey: .registered)
        try container.encode(self.tags, forKey: .tags)
        try container.encode(self.friends, forKey: .friends)
    }
}

// 定义匹配JSON中friends数组的Friend结构体
@Model
class FriendChallenge: Codable {
    var id: String
    var name: String
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }

    private enum CodingKeys: String, CodingKey {
        case id, name
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}


struct SubChallengeView: View {
    @Query var users: [UserChallenge]
    
    init(sortOrder: [SortDescriptor<UserChallenge>]) {
        _users = Query(sort: sortOrder)
    }
    
    var body: some View {
        List(users) { user in
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
    }
}

struct ChallengeMillstone10_12: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var sort = [
        SortDescriptor(\UserChallenge.name),
        SortDescriptor(\UserChallenge.age)
    ]


    var body: some View {
        NavigationView {
            SubChallengeView(sortOrder: sort)
            .navigationTitle("FriendFace")
            .toolbar(content: {
                Button("loadUser") {
                    fetchUsers()
                }
                Button("clean") {
                    clean()
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort",selection: $sort){
                        Text("Sort by Name")
                            .tag([SortDescriptor(\UserChallenge.name),
                                  SortDescriptor(\UserChallenge.age)
                                 ])
                        Text("Sort by Age")
                            .tag([
                                SortDescriptor(\UserChallenge.age),
                                SortDescriptor(\UserChallenge.name)
                            ])
                    }
                }
            })
        }
    }
    func clean() {
        try? modelContext.delete(model: UserChallenge.self)
    }

    func fetchUsers() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
               
                if let decodedUsers = try? JSONDecoder().decode([UserChallenge].self, from: data) {
                    DispatchQueue.main.async {
                        for user in decodedUsers{
                            modelContext.insert(user)
                        }
                        
                    }
                } else{
                    
                }
                
            } else {
                print("Error fetching users: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}

#Preview {
    ChallengeMillstone10_12()
        .modelContainer(for: UserChallenge.self)
}
