//
//  CoreData_Project11.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/10.
//

import SwiftUI


struct CoreData_Project11: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    var body: some View {
        VStack{
            List(students){ student in
                Text(student.name ?? "unknow")
            }
            Button("Add"){
                let firstNames = ["Tom","jeccy","linda","jescal"]
                let lastNames = ["bob","jams","touta","da"]
                
                let firstName = firstNames.randomElement()!
                let lastName = lastNames.randomElement()!
                let student = Student(context: moc)
                
                student.id = UUID()
                student.name = "\(firstName) \(lastName)"
                
                try? moc.save()
            }
        }
    }

}
#Preview {
    CoreData_Project11()
}
