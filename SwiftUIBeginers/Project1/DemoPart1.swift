//
//  D16Form.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/11.


// @State NavigationStack Form

import SwiftUI

struct DemoPart1: View {
    @State var tap = 0
    let students = ["Harry", "Hermione", "Ron","Hermione"]
    @State private var selectedStudent = "Harry"

    
    var body: some View {
        
        NavigationStack{

            Button("Tap Count: \(tap)") {
                tap += 1
            }
            
            Form {
            
                Picker("Your Chose", selection: $selectedStudent) {
                    ForEach(students, id: \.self){
                        Text($0)
                    }
                }
                
                Text("it's your chosen \(selectedStudent)")
                
                Section{
                    TextField("Enter your name", text: $selectedStudent)
                    Text("Hello, \(selectedStudent)!")
                }
                
                Section{
                    Text("Hello, world!")
                    Text("Hello, world!")
                }
             
                Text("Hello, world!")
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
    DemoPart1()
}
