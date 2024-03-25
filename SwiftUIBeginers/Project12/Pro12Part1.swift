//
//  Pro12Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/25.
//

import SwiftData
import SwiftUI

@Model
class UserPro12 {
    var name: String
    var city: String
    var joinDate: Date
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}


struct EditUserView: View {
    @Bindable var user: UserPro12
    var body: some View {
        Form{
            TextField("Name",text: $user.name)
            TextField("City",text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Pro12Part1:View {
    @Environment(\.modelContext) var modelContext
//    @Query(sort: \UserPro12.name) var users: [UserPro12]
    @Query(filter: #Predicate<UserPro12>{ user in
        user.name.localizedStandardContains("R") && user.city == "London"
    }, sort: \UserPro12.name) var users: [UserPro12]
    @State private var path = [UserPro12]()
    
    var body: some View {
        NavigationStack(path: $path, root: {
            List(users){ user in
                NavigationLink(value: user) {
                    Text(user.name)
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: UserPro12.self) { user in
                EditUserView(user: user)
            }
            .toolbar(content: {
                Button("Add User") {
                    
                    try? modelContext.delete(model: UserPro12.self)

                    let first = UserPro12(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = UserPro12(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = UserPro12(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = UserPro12(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
         
                }
            })
        })
        
    }
}

//#Preview {
//    do{
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let modelContainer = try ModelContainer(for: UserPro12.self, configurations: config)
//        let user = UserPro12(name: "Taylor Swift", city: "Nashville", joinDate: .now)
//        return EditUserView(user: user)
//            .modelContainer(modelContainer)
//    }catch{
//        return Text("Failed to create container: \(error.localizedDescription)")
//
//    }
//}

#Preview(body: {
    Pro12Part1()
        .modelContainer(for: UserPro12.self)
})
