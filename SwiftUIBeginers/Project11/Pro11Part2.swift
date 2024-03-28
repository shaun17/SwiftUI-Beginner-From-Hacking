//
//  SwiftUIView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/25.
//

import SwiftData
import SwiftUI

@Model
class StudentPro11 {
    var id: UUID
    var name: String
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

struct Pro11Part2: View {
    @Query var students: [StudentPro11]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Classroom")
            .toolbar(content: {
                Button("New Student") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    let student = StudentPro11(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
                    modelContext.insert(student)
                }
            })
        }
    }
}

#Preview {
    Pro11Part2()
        .modelContainer(for: StudentPro11.self)
}
