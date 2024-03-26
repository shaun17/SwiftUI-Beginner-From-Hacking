//
//  Pro12Part.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/26.
//

import SwiftData
import SwiftUI

@Model
class UserPro12Part2 {
    var name: String
    var city: String
    var joinDate: Date
    var jobs = [JobPro12]()

    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}


@Model
class JobPro12 {
    var name: String
    var priority: Int
    var owner: UserPro12Part2?
    init(name: String, priority: Int, owner: UserPro12Part2? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}


struct EditUserViewPart2: View {
    @Bindable var user: UserPro12Part2
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserViewPro12: View {
    @Query var users: [UserPro12Part2]

    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<UserPro12Part2>]) {
        _users = Query(filter: #Predicate<UserPro12Part2> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }

    var body: some View {
        List {
            ForEach(users){ user in
            NavigationLink(value: user) {
                HStack {
                        Text(user.name)

                        Spacer()

                        Text(String(user.jobs.count))
                            .fontWeight(.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(.blue)
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                    }
            }
            }
            .onDelete(perform: { indexSet in
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            })
        }
        .navigationTitle("Users")
        .navigationDestination(for: UserPro12Part2.self) { user in
            EditUserViewPart2(user: user)
        }
    }
}

struct Pro12Part2: View {
    @State private var showingUpcomingOnly = false
    @Environment(\.modelContext) var modelContext

    @State private var path = [UserPro12Part2]()
    
    @State private var sortOrder = [
        SortDescriptor(\UserPro12Part2.name),
        SortDescriptor(\UserPro12Part2.city)
    ]

    var body: some View {
        NavigationStack(path: $path, root: {
            
            UserViewPro12(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast,
                          sortOrder: sortOrder)
            

                .toolbar(content: {
                    EditButton()
                    
                    Button("Add User") {
                        try? modelContext.delete(model: UserPro12Part2.self)

                        let first = UserPro12Part2(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                        let second = UserPro12Part2(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                        let third = UserPro12Part2(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                        let fourth = UserPro12Part2(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

                        modelContext.insert(first)
                        modelContext.insert(second)
                        modelContext.insert(third)
                        modelContext.insert(fourth)
                    }

                    Button("add sample") {
                        
                        let user1 = UserPro12Part2(name: "Piper Chapman", city: "New York", joinDate: .now)
                        let job1 = JobPro12(name: "Organize sock drawer", priority: 3)
                        let job2 = JobPro12(name: "Make plans with Alex", priority: 4)

                        modelContext.insert(user1)

                        user1.jobs.append(job1)
                        user1.jobs.append(job2)
                    
                    }
                    Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                        showingUpcomingOnly.toggle()
                    }
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort",selection: $sortOrder){
                            Text("Sort by Name")
                                .tag([SortDescriptor(\UserPro12Part2.name),
                                      SortDescriptor(\UserPro12Part2.joinDate)
                                     ])
                            Text("Sort by Join Date")
                                .tag([
                                    SortDescriptor(\UserPro12Part2.joinDate),
                                    SortDescriptor(\UserPro12Part2.name)
                                ])
                        }
                    }
                    
                    
                })
        })
    }
}


#Preview(body: {
    Pro12Part2()
        .modelContainer(for: UserPro12Part2.self)
})
